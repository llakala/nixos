{ wrapperModules, wrappers, lib }:

wrapperModules.bat {
  flags = "--style=plain --pager='${lib.getExe wrappers.less} -RFX'";
}
