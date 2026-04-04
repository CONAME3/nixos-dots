{ config, ... }:
{
  sops = {
    secrets = import ./${config.data.hostname}/manifest.nix;
    defaultSopsFile = ./${config.data.hostname}/secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/sops-ssh.key" ];
    defaultSopsFormat = "yaml";
  };

  environment.variables = {
    SOPS_AGE_KEY_FILE = "/home/${config.data.username}/.config/sops/sops-nix.key";
  };
}
