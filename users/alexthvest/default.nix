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

    alacritty
    pfetch
    ranger
    flameshot

    google-chrome
    tdesktop
    discord

    libreoffice-fresh
    zathura

    # jetbrains.rider
    beekeeper-studio

    nodejs
    yarn

    dotnet-sdk
    docker-compose
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  ## fzf
  programs.fzf.enable = true;

  ## Home-Manager
  programs.home-manager.enable = true;
}
