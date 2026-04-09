{ config, pkgs, lib, ... }:
let
  cfg = config.module.program.steam;

in {
  options.module.program.steam.enable = lib.mkEnableOption "steam";
  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    hardware.steam-hardware.enable = true;
    programs.gamemode.enable = true;
    security.pam.loginLimits = [
      { domain = "*"; type = "soft"; item = "nofile"; value = "1048576"; }
      { domain = "*"; type = "hard"; item = "nofile"; value = "1048576"; }
    ];
  };
}
