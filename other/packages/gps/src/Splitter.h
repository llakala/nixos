#ifndef GIT_SPLITTER_H
#define GIT_SPLITTER_H
#include <fstream>
#include <string>
using namespace std;

class Splitter {
public:
  /*
   * Creates an instance of the splitter class.
   *
   * @param fullPath: whether to write each patch with its full filepath rather
   * than just its filename
   * @param byHunk: whether to split on every single hunk, rather than just by
   * file
   * @param outputDir: the directory to store the resulting patches in. Will be
   * created if it doesn't already exist
   */
  Splitter(bool fullPath, bool byHunk, string outputDir);

  /*
   * Split the patch stored at the given filename, and store the resulting
   * patches into outputDir (passed when instantiating a patch).
   *
   * @param filename the name of the patch to be split.
   */
  void split(string filename);

private:
  bool fullPath;
  bool byHunk;
  string outputDir;

  bool startsWith(string str, string with);
  bool endsWith(string str, string with);
  ifstream *openFile(string filename);
  void createOutputDir();
  string getFilename(string line);
  int splitByFile(ifstream *inputFile);
  int splitByHunk(ifstream *inputFile);
};
#endif
