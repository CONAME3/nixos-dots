{ config, lib, ... }:
{
  imports = lib.concatMap
    (directory: lib.mapAttrsToList (name: _: directory + "/${name}") (builtins.readDir directory)) 
    [ ./desktop ./drivers ./editors ./programs ./services ./tools ];
}
