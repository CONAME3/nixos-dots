{ config, pkgs, lib, ... }:
let
  cfg = config.module.tool.starship;

in {
  options.module.tool.starship.enable = lib.mkEnableOption "starship";
  config = lib.mkIf cfg.enable {
    home-manager.users.${config.data.username} = {
      programs.starship = {
        enable = true;

        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
