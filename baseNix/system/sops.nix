{ sops-nix, config, vars, ... }:

{

  imports =
  [
    sops-nix.nixosModules.sops
  ];

  sops =
  {
    defaultSopsFile = "${vars.secretsDirectory}/secrets.yaml";
    validateSopsFiles = false;
  };

  age =
  {
    sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    keyFile = "/var/lib/sops-nix/key.txt";
    generateKey = true;
  };

  secrets =
  {
    framework-password = {};
  };

}