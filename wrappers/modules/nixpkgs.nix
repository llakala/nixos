{ adios }:
{
  name = "nixpkgs";

  options = {
    pkgs = {
      type = adios.types.attrs;
    };
    lib = {
      type = adios.types.attrs;
      defaultFunc = { options }: options.pkgs.lib;
    };
  };
}
