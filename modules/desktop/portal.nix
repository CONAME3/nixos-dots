{ config, pkgs, lib, ... }:
let
  cfg = config.module.desktop.portal;

in {
  options.module.desktop.portal.enable = lib.mkEnableOption "portal";
  config = lib.mkIf cfg.enable {
    xdg.portal = {
      enable = true;

      xdgOpenUsePortal = true;
      config = {
        common = {
            default = [ "gtk" ];
        };

        hyprland = {
          default = [ "hyprland" "gtk" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        };
      };

      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
