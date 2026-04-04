{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nurpkgs.url = "github:nix-community/NUR";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    schnittstelle = {
      url = "github:CONAME3/schnittstelle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nurpkgs, ... }@inputs:
  let
    inherit (nixpkgs) lib;
    hosts = lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./hosts));

    mkSystem = hostname:
    let
      hostPath = ./hosts/${hostname};
      overlayPath = hostPath + /overlay;
      overlay = if builtins.pathExists overlayPath then [ (import overlayPath) ] else [];

    in nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; 
      specialArgs = { inherit inputs; };
      modules = [
      ({ lib, ... }: {
        options.data = {
          version = lib.mkOption { type = lib.types.str; default = "26.05"; };
          hostname = lib.mkOption { type = lib.types.str; default = hostname; };
          username = lib.mkOption { type = lib.types.str; default = "coname"; };
        };
      })
      {
        nixpkgs.overlays = [ nurpkgs.overlays.default ] ++ overlay;
        nixpkgs.config.allowUnfree = true;
      }
        inputs.disko.nixosModules.disko
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        inputs.schnittstelle.nixosModules.default
        inputs.nixvim.nixosModules.default
        (hostPath + /configuration.nix)
      ];
    };

  in {
    nixosConfigurations = lib.genAttrs hosts (hostname: mkSystem hostname);
  };
}
