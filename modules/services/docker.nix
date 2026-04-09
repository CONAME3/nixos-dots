{ config, pkgs, lib, ... }:
let
  cfg = config.module.service.docker;

in {
  options.module.service.docker.enable = lib.mkEnableOption "docker";
  config = lib.mkIf cfg.enable {
    users.users.${config.data.username}.extraGroups = [ "docker" ];
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = lib.mkDefault 1;
      "net.ipv4.conf.all.forwarding" = lib.mkDefault 1;
      "net.ipv6.conf.all.forwarding" = lib.mkDefault 1;
    };

    networking = {
      firewall = {
        enable = true;

        checkReversePath = false;
        trustedInterfaces = [ "docker0" ];
      };
      nftables.enable = true;
    };

    virtualisation.docker = {
      enable = true;

      extraOptions = "--dns 8.8.8.8";
    };

    environment.systemPackages = with pkgs; [
      ctop
      lazydocker
      docker-compose
      iptables
    ];
  };
}
