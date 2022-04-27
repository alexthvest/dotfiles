{ config, pkgs, ... }:

{
  imports = [
    ## Shell
    ./modules/shell/git.nix
    ./modules/shell/zsh.nix

    ## Editors
    ./modules/editors/neovim.nix
    ./modules/editors/vscode.nix
  ];

  home.packages = with pkgs; [
    exa
    calc
    alacritty

    pavucontrol
    xdotool

    alacritty
    pfetch
    bpytop
    ranger
    flameshot

    google-chrome
    tdesktop
    discord

    libreoffice-fresh
    zathura

    jetbrains.rider
    beekeeper-studio

    nodejs
    yarn

    dotnet-sdk
    docker-compose

    ## Icons
    papirus-icon-theme
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  ## fzf
  programs.fzf.enable = true;

  ## gestures
  services.fusuma = {
    enable = true;

    settings = {
      swipe = {
        "3".left.command = "xdotool key super+Right";
        "3".right.command = "xdotool key super+Left";
      };
    };
  };

  ## Home-Manager
  programs.home-manager.enable = true;
}
