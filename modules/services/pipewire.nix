{ config, pkgs, lib, ...}:
let
  cfg = config.module.service.pipewire;

in {
  options.module.service.pipewire.enable = lib.mkEnableOption "pipewire";
  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = lib.mkForce false;
    services.pipewire = {
      enable = true;

      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
      jack.enable = true;
    };
  };
}
