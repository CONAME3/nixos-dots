{ config, pkgs, lib, ... }:
let
  cfg = config.module.driver.nvidia;

in {
  options.module.driver.nvidia.enable = lib.mkEnableOption "nvidia";
  config = lib.mkIf cfg.enable {
    boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" "NVreg_PreserveVideoMemoryAllocations=1" ];
    boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    hardware.nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    environment.variables = {
      "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
      "LIBVA_DRIVER_NAME" = "nvidia";
      "GBM_BACKEND" = "nvidia-drm";
      "NVD_BACKEND" = "direct";
      "NIXOS_OZONE_WL" = "1";
    };
  };
}
