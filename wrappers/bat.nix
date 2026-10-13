{ promise, ... }:
{
  inputs = {
    less.from = { parent }: parent.less;
  };

  options = {
    flags.default = promise (
      { inputs, results }:
      let
        inherit (inputs.nixpkgs) lib;
      in
      [ "--style=plain" "--pager=${lib.getExe results.less}" ]
    );
  };
}
