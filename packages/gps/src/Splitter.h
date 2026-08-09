#ifndef GIT_SPLITTER_H
#define GIT_SPLITTER_H
#include <filesystem>
#include <fstream>
#include <string>
using namespace std;

class Splitter {
public:
  /*
   * Creates an instance of the splitter class.
   *
   * @param byHunk: whether to split on every single hunk, rather than just by
   * file
   * @param outputDir: the directory to store the resulting patches in. Will be
   * created if it doesn't already exist
   */
  Splitter(bool &byHunk, string &outputDir);

  /*
   * Split the patch stored at the given filename, and store the resulting
   * patches into outputDir (passed when instantiating a patch).
   *
   * @param filename the name of the patch to be split.
   */
  void split(string &filename);

private:
  bool fullPath;
  bool byHunk;
  filesystem::path outputDir;

  bool startsWith(string_view str, string_view with);
  bool endsWith(string_view str, string_view with);
  ifstream openFile(const string &filename);
  void createOutputDir();
  filesystem::path getFilename(string_view line);
  int splitByFile(ifstream &inputFile);
  int splitByHunk(ifstream &inputFile);
};
#endif
