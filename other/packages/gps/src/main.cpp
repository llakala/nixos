#include "Splitter.h"
#include <getopt.h>
#include <iostream>
#include <optional>
using namespace std;

void printUsage(char **argv) {
  cout << "Usage: " << argv[0] << " [<options>] <file>" << endl;
  cout << endl;
  cout << "Options:" << endl;
  cout << "    -f | --fullpath         Use the full path for each outputted patch." << endl;
  cout << "    -H | --hunk             Split every hunk into its own file." << endl;
  cout << "    -o | --output-dir       The directory to store the outputted patches in. Expected to be nonempty."
       << endl;
  cout << "    -h | --help             Show this page." << endl;
}

/*
 * Parse the options from stdin and set the passed variables to the correct state. If an option isn't passed, the
 * default state of the passed variable will be used.
 *
 * @param argc: The argument count
 * @param argv: A pointer to the arguments passed through stdin
 * @param filename: A pointer to a variable filename which will store the inputted variable.
 * @param fullPathFlag: A pointer to a variable for storeing whether the full path should be used for each outputted
 * patch
 * @param byHunkFlag: A pointer to a variable for storing whether the patch should be split by hunk
 * @param outputDir: A pointer to a variable for storing the output directory for the patches
 * */
void parseOptions(int argc, char **argv, optional<string> &filename, bool &fullPathFlag, bool &byHunkFlag,
                  string &outputDir) {
  // We have each longform option simply set `opt` to their short flag, so when
  // we're looping and parsing options, short and long form options are handled
  // identically
  static struct option longOptions[] = {
      {"fullpath", no_argument, nullptr, 'f'},
      {"hunk", no_argument, nullptr, 'H'},
      {"help", no_argument, nullptr, 'h'},
      {"output-dir", required_argument, nullptr, 'o'},
  };

  int opt;
  int optionIndex;
  while (true) {
    opt = getopt_long(argc, argv, "fHho:", longOptions, &optionIndex);
    // All options have been parsed. At this point, optind will set our location
    // in argv, so that we can read from whatever arguments weren't valid
    // options (in our case, the filename).
    if (opt == -1) {
      break;
    }

    switch (opt) {
    case 'f':
      fullPathFlag = true;
      break;

    case 'H':
      byHunkFlag = true;
      break;

    case 'o':
      outputDir = optarg;
      break;

    case 'h':
      printUsage(argv);
      exit(0);

    // A nonexistent option. getopt prints a special message here as well.
    default:
      printUsage(argv);
      exit(1);
    }
  }

  // Loop through all the arguments that weren't valid options. We're only
  // expecting one of these, and if we get more than one, we error.
  for (int index = optind; index < argc; index++) {
    if (filename) {
      cout << "Too many arguments passed - only one filename was expected." << endl;
      exit(1);
    } else {
      filename = make_optional<string>(argv[index]);
    }
  }
}

int main(int argc, char **argv) {
  bool fullPathFlag = false;
  bool byHunkFlag = false;
  string outputDir = "output";
  optional<string> filename = nullopt;

  parseOptions(argc, argv, filename, fullPathFlag, byHunkFlag, outputDir);

  // We made filename of type optional so we could easily detect if it hadn't
  // been set
  if (!filename) {
    cout << "Expected a filename to be passed, but found none." << endl;
    cout << "Please pass the path to some git patch to be split." << endl;
    return 1;
  }

  Splitter x(fullPathFlag, byHunkFlag, outputDir);
  x.split(*filename);

  return 0;
}
