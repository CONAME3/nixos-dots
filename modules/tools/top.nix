{ config, pkgs, lib, ... }:
let
  cfg = config.module.tool.top;

in {
  options.module.tool.top.enable = lib.mkEnableOption "top";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ atop ];
    home-manager.users.${config.data.username} = {
      home.packages = with pkgs; [
        htop
        nvtopPackages.full
      ];
    };
  };
}
