{ pkgs, hostVars, ...}:

{

  programs.firefox =
  {
    enable = true;

    package = (pkgs.wrapFirefox pkgs.firefox-unwrapped
    {

    })

    .overrideAttrs (oldAttrs:
    {
      buildCommand = oldAttrs.buildCommand +
      ''
      wrapProgram $out/bin/firefox \
        --set MOZ_ENABLE_WAYLAND 0 \
        --set MOZ_USE_XINPUT2 1
      '';
    });
  };


  programs.firefox.profiles.${hostVars.username} =
  {
    isDefault = true;
    settings =
    {

    };
  };



}