{ adios }:
{
  inputs = {
    less.path = "/less";
  };

  options = {
    flags.defaultFunc =
      { inputs }:
      let
        inherit (inputs.nixpkgs) lib;
        lessWrapper = inputs.less {};
      in
      [ "--style=plain" "--pager=${lib.getExe lessWrapper}" ];
  };
}
