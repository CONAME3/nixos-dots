{ config, pkgs, lib, ... }:
let
  cfg = config.module.desktop.ghostty;

in {
  options.module.desktop.ghostty.enable = lib.mkEnableOption "ghostty";
  config = {
    environment.systemPackages = with pkgs; [ ghostty.terminfo ];

    home-manager.users.${config.data.username} = lib.mkIf cfg.enable {
      programs.ghostty = {
        enable = true;

        settings = {
          window-decoration = false;

          cursor-style = "block";
          cursor-style-blink = false;
          cursor-click-to-move = true;
          copy-on-select = "clipboard";

          scrollback-limit = 10000;
          confirm-close-surface = false;
          mouse-hide-while-typing = false;
          shell-integration = "detect";

          keybind = [
            "ctrl+shift+c=copy_to_clipboard"
            "ctrl+shift+v=paste_from_clipboard"
          ];
        };
      };
    };
  };
}
