{ config, pkgs, lib, ... }:
let
  cfg = config.module.service.greetd;

in {
  options.module.service.greetd = {
    enable = lib.mkEnableOption "greetd";
    exec = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };
  config = lib.mkIf cfg.enable {
    systemd.services."getty@tty1".enable = false;
    services.greetd = {
      enable = true;

      settings = {
        default_session = {
          user = config.data.username;
          command = cfg.exec;
        };
      };
    };
  };
}
