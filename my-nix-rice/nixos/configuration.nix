# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
# TUNA mirror repository.
 nix.settings = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"  # Fallback to official cache
    ];
    trusted-substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.displayManager.ly = {
     enable = true;
};

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.ryan = {
    shell = pkgs.zsh;
};
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ryan = {
    isNormalUser = true;
    description = "Ryan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = "ryan";

  # Install firefox.
  programs.firefox.enable = true;

  #install hyprland and activate it.
  programs.hyprland = {
     enable = true;
     xwayland.enable = true;
  };

# Black listing nvidia drivers.
  boot.blacklistedKernelModules = [ "nvidia" "nouveau" "nvidia_drm" "nvidia_modeset" ];
  fonts = {
    packages = with pkgs; [
      nerd-fonts.adwaita-mono
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Adwaita Mono Nerd Font"];
      };
    };
  };
# Enabling modsetting drivers for intel integrated graphics.
  services.xserver = {
    videoDrivers = [ "modesetting" ];
 };
# Stuff for intel drivers.
 
 hardware.opengl = {
    enable = true;
  }; 
programs.waybar.enable = true;

programs.zsh = {
  enable = true;
  autosuggestions.enable = true;  # Official NixOS module
  syntaxHighlighting.enable = true;  # Optional but recommended
};

  #flakes and shit
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   #Basic stuff.
   git # Come on we know why we need git. Its preinstalled but i like it in my PATH.
   waybar 
   wget     # I dont know why I need this but it will come in handy because i dont like going in browsers to download stuff.
   neovim   # Neovim is good.
   hyprland # Easy to configure plus it is very nice.
   xfce.thunar
   zsh-autosuggestions
   xfce.thunar-volman
   zsh-syntax-highlighting
   xfce.tumbler
   gvfs
   alacritty  # Might go back to kitty but will try for right now.
   dunst
   thunderbird
# I might need this because it just is interesting and I understand it better than other windows stuff.
   librewolf #fuck firefox   
   hyprpaper
   xfce.thunar
   steam
   inkscape
   zsh
   fuzzel
   fastfetch
   telegram-desktop
   hyprpaper
   hyprpicker
   grim
   slurp
   blueman
   wine
   wine-wayland
   gimp
   # Python Tools.
   python3.pkgs.pynvim
   python3   		    # Python interpreter (latest stable)
   python3.pkgs.pip  # Package manager
   python3.pkgs.setuptools  # For building packages
   python3.pkgs.wheel       # For installing wheels
   python3.pkgs.virtualenv  # Virtual environments (optional, but useful)
   python3.pkgs.venvShellHook # Nix-optimized venv setup. 
   python3.pkgs.python-lsp-server  # LSP server (for Neovim LSP support)
   python3.pkgs.debugpy            # Debugger (VS Code debug protocol, works with Neovim)
   python3.pkgs.ipython            # Enhanced REPL
   python3.pkgs.pytest             # Testing framework
   python3.pkgs.pytest-cov         # Test coverage
   python3.pkgs.black              # Code formatter
   python3.pkgs.ruff               # Ultra-fast linter (alternative to flake8)
   python3.pkgs.isort              # Import sorter
   python3.pkgs.mypy              # Static type checker
   
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
