{ config, pkgs, lib, ... }:
let
  cfg = config.module.tool.bash;

in {
  options.module.tool.bash.enable = lib.mkEnableOption "bash";
  config = lib.mkIf cfg.enable {
    programs.bash.completion.enable = true;
    home-manager.users.${config.data.username} = {
      programs.bash = {
        enable = true;
        enableCompletion = true;

        historyControl = [ "ignoredups" "ignorespace" ];
        historySize = 10000;
        historyFileSize = 20000;
        

        shellAliases = {
          rb = "sudo nixos-rebuild switch --flake .#${config.data.hostname}";
        };

        initExtra =
        ''
          bind '"\e[A": history-search-backward'
          bind '"\e[B": history-search-forward'

          bind "set show-all-if-ambiguous on"
          bind "set menu-complete-display-prefix on"

          shopt -s checkwinsize
          shopt -s cdspell
        '';
      };
    };
  };
}
