{ config, pkgs, lib, ... }:
let
  cfg = config.module.tool.fastfetch;

in {
  options.module.tool.fastfetch.enable = lib.mkEnableOption "fastfetch";
  config = lib.mkIf cfg.enable {
    home-manager.users.${config.data.username} = {
      programs.fastfetch = {
        enable = true;
      };
    };
  };
}
