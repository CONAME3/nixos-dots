{ config, pkgs, lib, ... }:
let
  cfg = config.module.program.obs;

in {
  options.module.program.obs.enable = lib.mkEnableOption "obs";
  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };
  };
}
