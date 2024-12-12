
{ config, pkgs, ... }:

{

#----------------------------------------------------------------------- 
boot.kernelParams = [ "copytoram" ]; #20241210

services.fail2ban.enable = true;

#----------------------------------------------------------------------- 
# Allow unfree packages,  NIXPKGS_ALLOW_UNFREE=1
nixpkgs.config.allowUnfree = true;
nixpkgs.config.allowUnsupportedSystem = true;
# nixpkgs.config.allowUnfreePredicate = (pkg: false);

#----------------------------------------------------------------------- 
# Open ports in the firewall.
networking.firewall.allowedTCPPorts = [ 80 443 22 ];
networking.firewall.allowedUDPPorts = [ 80 443 ];
# Or disable the firewall altogether.
networking.firewall.enable = true;
networking.firewall.allowPing = true;

#-----------------------------------------------------------------------    

services.openssh.enable = true;  # Enable the OpenSSH daemon.

# services.openssh = {
#   enable = true;
#   ports = [ 22 ];
#   settings = {
#     PasswordAuthentication = true;
#     AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
#     UseDns = true;
#     X11Forwarding = false;
#     PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
#   };
# };

#----------------------------------------------------------------------- 
# virt-manager
virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;

#----------------------------------------------------------------------- 
# kasm - https://www.kasmweb.com/docs/latest/index.html, https://mynixos.com/nixpkgs/options/services.kasmweb
#services.kasmweb.enable = true;
# services.kasmweb.listenAddress = "0.0.0.0";
# services.kasmweb.datastorePath = "/var/lib/kasmweb";
# services.kasmweb.defaultAdminPassword = "xxxxxxxxxxxx";
# services.kasmweb.defaultUserPassword = "xxxxxxxxxxxx";
# services.kasmweb.redisPassword = "xxxxxxxxxxxx";
# services.kasmweb.listenPort = 443;

# nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "kasmweb ];

#----------------------------------------------------------------------- 
# virtualbox - https://nixos.wiki/wiki/VirtualBox
# virtualisation.virtualbox.host.enable = true;
# users.extraGroups.vboxusers.members = [ "uuu" ];
# virtualisation.virtualbox.host.enableExtensionPack = true;
# virtualisation.virtualbox.guest.enable = true;
# virtualisation.virtualbox.guest.draganddrop = true;

#----------------------------------------------------------------------- 
# docker
virtualisation.docker.enable = true;
users.extraGroups.docker.members = [ "uuu" ];
virtualisation.docker.rootless = {
  enable = true;
  setSocketVariable = true;
};

#----------------------------------------------------------------------- 
 # podman
 virtualisation.containers.enable = true;
   virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

#----------------------------------------------------------------------- 
  # reymar firejail
  programs.firejail = {
  enable = true;
  wrappedBinaries = {
    sublime= {
      executable = "${pkgs.sublime}/bin/sublime";
      profile = "${pkgs.firejail}/sublime.profile";
      extraArgs = [ "--net none" ];
    };
    gimp= {
      executable = "${pkgs.gimp}/bin/gimp";
      profile = "${pkgs.firejail}/gimp.profile";
      extraArgs = [ "--net none" ];
    };
  };
};  

#----------------------------------------------------------------------- 
# tor
# services.tor.enable = true;
# services.tor.enableGeoIP = true;
# services.tor.client.enable = true;

#----------------------------------------------------------------------- 
 programs.dconf.enable = true;
 services.clamav.scanner.enable = true; #
 services.clamav.updater.enable = true; #
 services.clamav.daemon.enable = false; #

#----------------------------------------------------------------------- 
# add user to group
users.extraUsers.uuu = {
    isNormalUser = true;
    home = "/home/uuu";
    extraGroups = [ "wheel" "networkmanager" ];
};

#----------------------------------------------------------------------- 
programs.nix-ld.enable = true;
programs.nix-ld.libraries = with pkgs; [
  # Add any missing dynamic libraries for unpackaged programs
  # here, NOT in environment.systemPackages
  # run: /opt/vdhcoapp/vdhcoapp install
  vdhcoapp 
];

#----------------------------------------------------------------------- 

# Automatic Garbage Collection - reymar
nix.gc = {
automatic = true;
dates = "weekly";
options = "--delete-older-than 2d";
};

#----------------------------------------------------------------------- 
# Auto system update - reymar
# system.autoUpgrade = { enable = true; };

#----------------------------------------------------------------------- 
# apparmor - reymar
security.apparmor.enable = true;

#----------------------------------------------------------------------- 
# enables support for Bluetooth
hardware.bluetooth.enable = true; 
hardware.bluetooth.powerOnBoot = true; 
services.blueman.enable = true;
#----------------------------------------------------------------------- 
#Automatic updates
#system.autoUpgrade.enable  = true;
#system.autoUpgrade.allowReboot  = false;
#----------------------------------------------------------------------- 
#services.flatpak.enable = true; #cannot use in xfce
#----------------------------------------------------------------------- 
# automount - https://nixos.wiki/wiki/Filesystems
boot.supportedFilesystems = [ "ntfs" ]; #NTFS

# https://www.google.com/search?client=firefox-b-d&q=x-systemd.automount
# https://youtu.be/bzgQiqEEuWI?list=UULF0JJtK3m8pwy6rVgnBz47Rw&t=4228

} # ----end
