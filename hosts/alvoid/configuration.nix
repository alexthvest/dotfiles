{ config, pkgs, ... }:

{
  imports = [
    ## Hardwade
    ./hardware-configuration.nix

    ## Modules
    ../../modules/desktop/picom.nix
    ../../modules/system/pipewire.nix
  ];

  modules = {
    ## Pipewire
    pipewire.enable = true;

    ## Picom
    picom = {
      enable = true;
      fade = true;
    };
  };

  # Boot loader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  # Networking
  networking = {
    hostName = "alvoid";

    firewall.enable = true;
    wireless.enable = false;
    networkmanager.enable = true;

    useDHCP = false;

    interfaces = {
      # enp4s0f3u2.useDHCP = true;
      wlp2s0.useDHCP = true; 
    };
  };

  # Nix
  nix = {
    package = pkgs.nixUnstable;

    autoOptimiseStore = true;
    trustedUsers = [ "root" "@wheel" ];

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Date & Time
  time = {
    timeZone = "Europe/Moscow";
    hardwareClockInLocalTime = true;
  };

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    layout = "us,ru";
    xkbOptions = "eurosign:e, grp:caps_toggle";

    libinput = {
      enable = true;

      touchpad = {
        accelProfile = "flat";
        accelSpeed = "0.4";

        tapping = true;
        naturalScrolling = true;
      };
    };

    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+awesome";
    };

    windowManager = {
      awesome = {
        enable = true;
        package = pkgs.awesome-git;
      };
    };

    desktopManager.xterm.enable = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alexthvest = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "networkmanager" "docker" ]; 
    initialPassword = "123";
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    acpi
    acpid
    zip
    unzip
    brightnessctl
  ];

  hardware = {
    bluetooth.enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "monthly";
        flags = [ "--all" ];
      };
    };
  };

  services = {
    blueman.enable = true;
    acpid.enable = true;
    # printing.enable = true;

    tlp = {
      enable = false;
      settings = {
        USB_AUTOSUSPEND = 0;
      };
    };
  };

  programs = {
    zsh.enable = true;
  };

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      corefonts
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "CascadiaCode"
        ];
      })
    ];

    fontconfig.defaultFonts = {
      serif = [ "DM Sans" ];
      monospace = [ "DM Mono" "CascadiaCode" ];
    };
  };

  system.stateVersion = "21.11";
}

