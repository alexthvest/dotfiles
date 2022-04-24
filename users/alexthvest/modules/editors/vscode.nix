{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      ## Theme
      # dnlytras.nord-wave
      # mostik.jetbrainsicons
      # miguelsolorio.fluent-icons

      ## Git
      eamodio.gitlens

      ## Frontend
      # johnsoncodehk.volar

      # Languages
      jnoortheen.nix-ide

      ## Utilities
      esbenp.prettier-vscode
      mikestead.dotenv
    ];
  };
}
