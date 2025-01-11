{ myLib }:

input:
  myLib.filterNixFiles ( myLib.resolveFolders input )
