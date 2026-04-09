{ config, pkgs, lib, ... }:
let
  cfg = config.module.desktop.hypridle;

in {
  options.module.desktop.hypridle = {
    enable = lib.mkEnableOption "hypridle";
    lock_cmd = lib.mkOption {
      type = lib.types.str;
      default = "loginctl lock-session";
    };
    dpms_on_cmd = lib.mkOption {
      type = lib.types.str;
      default = "hyprctl dispatch dpms on";
    };
    dpms_off_cmd = lib.mkOption {
      type = lib.types.str;
      default = "hyprctl dispatch dpms off";
    };
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.${config.data.username} = {
      services.hypridle = {
        enable = true;

        settings = {
          general = {
            lock_cmd = cfg.lock_cmd;
            before_sleep_cmd = cfg.lock_cmd;
            after_sleep_cmd = cfg.dpms_on_cmd;
          };

          listener = [
          {
            timeout = 120;
            on-timeout = cfg.lock_cmd;
          }
          {
            timeout = 600;
            on-timeout = cfg.dpms_off_cmd;
            on-resume = cfg.dpms_on_cmd;
          }
          {
            timeout = 1200;
            on-timeout = "systemctl suspend";
          }
          ];
        };
      };
    };
  };
}
