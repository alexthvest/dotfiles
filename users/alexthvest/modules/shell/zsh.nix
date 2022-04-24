{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;

    shellAliases = {
      ls = "${pkgs.exa}/bin/exa -a -s type --no-user --no-time --no-filesize";
      lt = "${pkgs.exa}/bin/exa --tree";
      ll = "ls -l";

      weather = "${pkgs.curl}/bin/curl -4 https://wttr.in/Ivanovo";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";

      plugins = [
        "git"
      ];
    };
  };
}
