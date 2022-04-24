{
  description = "LaTeX Template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    latex = with pkgs; texlive.combine {
      inherit (texlive) scheme-basic latexmk xetex biber cyrillic polyglossia fontspec graphics float geometry hyperref chngcntr csquotes biblatex biblatex-gost caption titlesec amsmath amsfonts;
    };
  in
  {
    devShell.${system} = pkgs.mkShell {
      buildInputs = [ pkgs.cmake latex ];
    };
  };
}
