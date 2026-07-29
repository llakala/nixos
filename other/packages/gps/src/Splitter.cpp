#include "Splitter.h"
#include <algorithm>
#include <filesystem>
#include <iostream>
#include <string>

using namespace std;
using filesystem::create_directories;
using filesystem::exists;
using filesystem::filesystem_error;
using filesystem::is_directory;

Splitter::Splitter(bool &fullPath, bool &byHunk, string &outputDir) {
  this->fullPath = fullPath;
  this->byHunk = byHunk;

  // Remove trailing slashes from outputDir
  while (endsWith(outputDir, "/")) {
    outputDir.erase(outputDir.length() - 1);
  }
  this->outputDir = outputDir;
  createOutputDir();
}

void Splitter::split(string &filename) {
  ifstream *inputFile = openFile(filename);

  int numFiles;
  if (byHunk) {
    numFiles = splitByHunk(inputFile);
  } else {
    numFiles = splitByFile(inputFile);
  }
  cout << "Input file '" << filename << "' was split into " << numFiles << " files." << endl;
  cout << "Storing files to output directory '" << outputDir << "/'." << endl;

  inputFile->close();
  delete inputFile;
}

/*
 * String helper function to check if a given string starts with some other substring.
 *
 * @return whether the first string starts with the second one or not
 * */
bool Splitter::startsWith(string_view str, string_view with) {
  return str.rfind(with, 0) == 0;
}

/*
 * String helper function to check if a given string ends with some other substring.
 *
 * @return whether the first string ended with the second one or not
 * */
bool Splitter::endsWith(string_view str, string_view with) {
  return str.rfind(with) == (str.length() - with.length());
}

/*
 * Open the file at the passed filename, and return a pointer to the file
 * object. Errors out if the file doesn't exist.
 *
 * @param filename: the name of the file to read from
 * @return the file object
 * */
ifstream *Splitter::openFile(string &filename) {
  // We use `new` to allow the pointer to live outside of the stack, so it lasts
  // after this stack frame closes.
  ifstream *inputFile = new ifstream(filename);
  // .good checks whether .open() was successful
  if (!inputFile->good()) {
    cout << "Input file '" << filename << "' doesn't exist." << endl;
    cout << "Please pass a valid filename and try again." << endl;
    exit(1);
  }
  return inputFile;
}

/*
 * Create the output directory if it's valid. Errors if:
 * 1. an existing file has the same name as the directory to be created
 * 2. the directory already has files within it
 * 3. the directory can't be created due to some permission
 * */
void Splitter::createOutputDir() {
  if (!exists(outputDir)) {
    try {
      // create_directories allows passing nested directories that don't exist,
      // like `mkdir -p`
      create_directories(outputDir + "/");
    } catch (filesystem_error &error) {
      cout << "Got error: " << error.what() << endl;
      cout << "Invalid output directory - please try again with a different directory." << endl;
      exit(1);
    }
  }
  // We won't be able to create the output dir if a file with the same name
  // already exists
  else if (!is_directory(outputDir)) {
    cout << "Tried to create output dir '" << outputDir << "/', but a file named '" << outputDir << "' already existed."
         << endl;
    cout << "Please move/delete it and try again." << endl;
    exit(1);
  }
  // If the output dir _is_ empty, we'll be able to exit without any of these
  // conditions triggering
  else if (!filesystem::is_empty(outputDir + "/")) {
    cout << "Output dir '" << outputDir << "/' already existed and was nonempty." << endl;
    cout << "Please move/delete its contents and try again." << endl;
    exit(1);
  }
}

/*
 * Get the filename of the patch to be created based on the first line of the
 * header for the current hunk.
 *
 * @param line: line of the form `diff --git .*`
 * @return: the filename to be used, including the output directory
 * */
string Splitter::getFilename(string_view line) {
  int lastSpacePos = line.find_last_of(' ');
  string filename = line.substr(lastSpacePos + 1).data();

  if (fullPath) {
    // First cut off initial `b/`, then replace all existing slashes with
    // backslashes.
    int slashPos = filename.find_first_of('/');
    filename = filename.substr(slashPos + 1);
    replace(filename.begin(), filename.end(), '/', '\\');
  } else {
    int slashPos = filename.find_last_of('/');
    filename = filename.substr(slashPos + 1);
  }

  return outputDir + "/" + filename;
}

/*
 * Given a pointer to some filestream containing a git patch, split the patch
 * per modified file in the patch.
 *
 * @param inputFile: pointer to the filstream to be read from
 * @return: the number of files that have been created
 * */
int Splitter::splitByFile(ifstream *inputFile) {
  int numFiles = 0;
  string line;
  ofstream outfile;

  while (getline(*inputFile, line)) {
    // Start of a new file within the patch
    if (startsWith(line, "diff --git")) {
      if (outfile) {
        outfile.close();
      }
      outfile.open(getFilename(line) + ".patch");
      numFiles++;
      outfile << line << endl;
    }
    // If we've already seen a `diff --git` line and are now just waiting for
    // the next one, or the input file to end
    else if (outfile) {
      outfile << line << endl;
    }
  }

  if (outfile) {
    outfile.close();
  }
  return numFiles;
}

/*
 * Given a pointer to some filestream containing a git patch, split the patch
 * per hunk in the patch.
 *
 * @param inputFile: pointer to the filstream to be read from
 * @return: the number of files that have been created
 * */
int Splitter::splitByHunk(ifstream *inputFile) {
  string line;

  // We collect the header so we can reuse it for all the hunks in a patch
  stringstream header;
  ofstream outfile;

  string currentFilename;
  int numFiles = 0;
  int hunkNumber = 1;
  bool inHeader = true;

  while (getline(*inputFile, line)) {
    if (startsWith(line, "diff --git")) {
      // If this isn't the first file in the input patch
      if (outfile) {
        // If the header never ended, the last patch was only a header with no
        // hunks - write its contents to file
        // rdbuf consumes the whole header, so we don't have to reset it
        if (inHeader) {
          outfile << header.rdbuf();
        } else {
          header.str("");
        }
        outfile.close();

        // Reset all tracking data for the new file
        hunkNumber = 1;
        inHeader = true;
      }

      currentFilename = getFilename(line);
      outfile.open(currentFilename);
      numFiles++;
      header << line << endl;
    }
    // Start of a hunk
    else if (startsWith(line, "@@")) {
      // If we're in the first hunk of the file, simply stop collecting the header
      if (inHeader) {
        inHeader = false;
      } else {
        // Not the first hunk of the file - need to create a new file for the
        // new hunk
        outfile.close();
        hunkNumber++;
        numFiles++;
        outfile.open(currentFilename + "-" + to_string(hunkNumber));
      }

      // Write the collected header and start of hunk to the file
      // We use seekg to go back to the beginning of the header for the next
      // hunk
      outfile << header.rdbuf();
      header.seekg(0);
      outfile << line << endl;
    }
    // Seen `diff --git` but not `@@`. Everything goes into the header, since we
    // may need to reuse the header for all the hunks.
    else if (inHeader) {
      header << line << endl;
    }
    // In a hunk - can write directly to the outfile. It should always exist,
    // but can't be too careful.
    else {
      if (outfile) {
        outfile << line << endl;
      }
    }
  }

  // If the last patch contained only a header and no hunks, then there aren't
  // going to be any hunks -
  if (outfile) {
    if (inHeader) {
      outfile << header.rdbuf();
    }
    outfile.close();
  }
  return numFiles;
}
