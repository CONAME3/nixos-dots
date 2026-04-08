{ config, pkgs, lib, ... }:
let
  cfg = config.module.tool.direnv;

in {
  options.module.tool.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf cfg.enable {
    home-manager.users.${config.data.username} = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;

        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
