{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.modules.picom;
in
{
  options.modules.picom = {
    enable = mkEnableOption "picom";

    fade = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.picom = {
      enable = true;
      experimentalBackends = true;

      fade = cfg.fade;
      fadeDelta = 5;

      shadow = true;
      shadowOpacity = 0.25;
      shadowOffsets = [ (-40) (-40) ];

      shadowExclude = [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g = 'Rofi'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "class_g = 'awesome'"
        "_GTK_FRAME_EXTENTS@:c"
      ];
    };
  };
}
