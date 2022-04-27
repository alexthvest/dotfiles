{
  description = "My NixOS Configuration";

  inputs = {
    ## Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    ## Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ## Nixpkgs f2k
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";

    overlays = with inputs; [
      nixpkgs-f2k.overlay
    ];

    pkgs = import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system overlays;
      config.allowUnfree = true;
    };
  in
  {
    ## NixOS
    nixosConfigurations = {
      alvoid = nixpkgs.lib.nixosSystem rec {
        inherit system pkgs;

        modules = [
          ./hosts/alvoid/configuration.nix
        ];
      };
    };

    ## Home Manager
    homeManagerConfigurations = {
      alexthvest = home-manager.lib.homeManagerConfiguration rec {
        inherit system pkgs;

        username = "alexthvest";
        homeDirectory = "/home/alexthvest";

        stateVersion = "21.11";

        extraSpecialArgs = {
          inherit pkgs-unstable;
        };

        configuration = {
          nixpkgs.overlays = overlays;
          imports = [ ./users/alexthvest ];
        };
      };
    };

    ## Templates
    templates = import ./templates;
  };
}
