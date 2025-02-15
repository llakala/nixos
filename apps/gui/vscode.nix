{ pkgs, ... }:

{
  hm.programs.vscode =
  {
    enable = true;

    package = pkgs.vscode.override
    {
      commandLineArgs =
      [ # Vscode isn't really ready
      ];
    };
  };

}
