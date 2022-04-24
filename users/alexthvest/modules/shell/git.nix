{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "alexthvest";
    userEmail = "alexthvest@gmail.com";

    aliases = {
      st = "status -u -sb";
      ll = "log --oneline --graph";
      cm = "commit -m";
      rv = "remove -v";
      gl = "config --global -l";
    };

    extraConfig = {
      init.defaultBranch = "master";
    };
  };
}
