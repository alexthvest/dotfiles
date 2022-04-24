{ config, pkgs, lib, ... }:

let
  cfg = config.modules.pipewire;
in
{
  options.modules.pipewire = {
    enable = lib.mkEnableOption "pipewire";
  };

  config = lib.mkIf cfg.enable {
    sound.enable = true;

    security = {
      rtkit.enable = true;
    };

    hardware = {
      pulseaudio.enable = false;
    };

    services.pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
      jack.enable = true;
    };
  };
}
