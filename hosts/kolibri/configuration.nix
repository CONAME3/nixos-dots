{ ... }:
{
  nix.settings = {
    max-jobs = "auto";
    cores = 4;
  };

  imports = [
    ../common.nix
  ];
}
