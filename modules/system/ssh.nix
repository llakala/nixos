{
  services.openssh.enable = true;

  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
    extraConfig = ''
      Host github.com
       HostName github.com
       IdentityFile ~/.ssh/auth_key
    '';
    knownHosts = {
      "git.lix.systems" = {
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL+li7S+VH+O2F8lehYE9oBmx7SLGGLl+UQDaTRA7iMM";
      };
    };
  };

  environment.variables = {
    SSH_ASKPASS_REQUIRE = "prefer";
  };
}
