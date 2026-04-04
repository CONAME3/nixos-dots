{ config, lib, ... }:
{
  imports = lib.mapAttrsToList 
    (name: _: ./. + "/${name}/theme.nix") 
    (lib.filterAttrs (name: type: type == "directory" && builtins.pathExists (./. + "/${name}/theme.nix")) (builtins.readDir ./.));
}
