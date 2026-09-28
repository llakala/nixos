{ promise, ... }:
{
  inputs = {
    less.from = { parent }: parent.less;
  };

  options = {
    flags.default = promise (
      { inputs }:
      let
        inherit (inputs.nixpkgs) lib;
        lessWrapper = inputs.less {};
      in
      [ "--style=plain" "--pager=${lib.getExe lessWrapper}" ]
    );
  };
}
