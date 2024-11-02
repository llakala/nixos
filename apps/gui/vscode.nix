{ pkgs-unstable, ... }:

{


  hm.programs.vscode =
  {
    enable = true;

    package = pkgs-unstable.vscode.override
    {
      commandLineArgs =
      [ # Vscode isn't really ready
      ];
    };
  };

}
