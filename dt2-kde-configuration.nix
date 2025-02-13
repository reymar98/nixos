# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# https://status.nixos.org/

{ config, pkgs, ... }:

let
    myNixpkgs = import (builtins.fetchGit {
        name = "nixos-24.11";
        url = https://github.com/nixos/nixpkgs/;
        rev = "b681065d0919f7eb5309a93cea2cfa84dec9aa88";
    }) {};
in {

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./common.nix
      ./steam.nix  
      ./apps.nix
      # ./kasmweb-server.nix
      # ./kasmweb-module.nix
      # ./samba-dt.nix 
      # ./vdhcoapp.nix       
      # ./wireshark.nix
      # ./shell.nix
    ];

  time.hardwareClockInLocalTime = true; #20240812 to synch with window time

  # Bootloader for DT2
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
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  #----------------------------------------------------------------------- 
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  #----------------------------------------------------------------------- 
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # kde
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  #----------------------------------------------------------------------- 
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  #----------------------------------------------------------------------- 
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  #----------------------------------------------------------------------- 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.uuu = {
    isNormalUser = true;
    description = "uuu";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  #----------------------------------------------------------------------- 
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  #----------------------------------------------------------------------- 

  #----------------------------------------------------------------------- 
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
#----------------------------------------------------------------------- 
  nixpkgs.config.permittedInsecurePackages = [
  "openssl-1.1.1w"
  "qbittorrent-4.6.4" 
  "dotnet-runtime-wrapped-6.0.36"
  "dotnet-runtime-6.0.36" 
  "dotnet-sdk-wrapped-6.0.428"
  "dotnet-sdk-6.0.428"
  ]; 
#----------------------------------------------------------------------- 
# Enable cron service - reymar
services.cron = {
  enable = true;
  systemCronJobs = [
    "@reboot       root    bash /home/uuu/Documents/linux/39-start.sh"
    "*/2 * * * *   root    bash /home/uuu/Documents/linux/39-rename.sh"
    "02 06 * * *   root    systemctl suspend"
  ];
};

} #=========== end ====================
