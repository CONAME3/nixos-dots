{ config, pkgs, lib, ... }:
let
  cfg = config.module.program.gimp;

in {
  options.module.program.gimp.enable = lib.mkEnableOption "gimp";
  config = lib.mkIf cfg.enable {
    home-manager.users.${config.data.username} = {
      home.packages = with pkgs; [ 
        gimp
      ];
    };
  };
}
