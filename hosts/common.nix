{ config, pkgs, ... }:
{
  system.stateVersion = config.data.version;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = config.data.hostname;
  users.users.${config.data.username} = {
    isNormalUser = true;
    group = config.data.username;
    extraGroups = [ "wheel" ];
  };
  users.groups.${config.data.username} = {};

  imports = [
    ../secrets/secretsInit.nix
    ../modules/modulesInit.nix
    ../themes/themesInit.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {};
    users.${config.data.username} = {
      home.stateVersion = config.data.version;
      home.username = config.data.username;
      home.homeDirectory = "/home/${config.data.username}";
    };
  };

  services.dbus.enable = true;
  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [
    curl
    wget
    dig
    mtr
    unhide
    wakeonlan
    sops
    ssh-to-age
  ];
}
