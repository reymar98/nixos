{ config, pkgs, ... }:
{
  
  #----------------------------------------------------------------------- 
  # https://flatpak.org/setup/NixOS
  services.flatpak.enable = true; #cannot use in xfce
  # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo 
  #----------------------------------------------------------------------- 
  # https://nixos.wiki/wiki/WayDroid
  virtualisation.waydroid.enable = true;
  #----------------------------------------------------------------------- 
  
  #----------------------------------------------------------------------- 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  # imagemagick # for creating gif
  # rPackages.SAFARI
  # vivaldi
  # wireshark #
  # kazam  #-screenrecorder 
  # jetbrains.pycharm-community-src #
  # onboard # virtual keyboard
  # simplescreenrecorder
  # samba
  # kasmweb #--Streaming containerized apps and desktops to end-users
  qbittorrent
  firewalld
  zeroadPackages.zeroad-unwrapped #--Historical real-time strategy game. 
  zeroadPackages.zeroad-data #--Historical real-time strategy game. 
  openra #--Open-source implementation of Command & Conquer.
  # kiwix  #--offline reader (flatpak)
  yt-dlp
  fdupes #--find duplicates
  cryptsetup # encrypt partition
  ecryptfs #--encrypt folder
  veracrypt #--encrypt drive
  dislocker #--access bitlocker encrypted drive
  glaxnimate #--kdenlive
  handbrake #---video convesion
  steam #--steam
  steam-run #--steam
  protonup #--steam
  qemu
  libreoffice-qt
  obs-studio #-screenrecorder/streaming
  ffmpeg-full #
  dislocker #--access bitlocker encrypted drive
  dive #--podman
  podman-tui #--podman
  docker #--docker
  docker-compose #--podman
  nix-prefetch-docker
  vscodium
  python3 #
  python312Packages.pip
  maliit-keyboard  # virtual keyboard
  waydroid #--android system
  flatpak #--repository for apps
  pavucontrol
  gnome-disk-utility
  inetutils # ftp etc
  dpkg
  chromium
  # ungoogled-chromium
  # librewolf # browser
  # brave   
  httrack  #--website copier
  libwebcam  #--for webcam
  bottles
  vlc
  wget
  meld
  git
  htop
  sublime4
  firejail
  apparmor-pam
  apparmor-utils
  apparmor-parser
  apparmor-profiles
  apparmor-bin-utils
  apparmor-kernel-patches
  libapparmor
  zip
  p7zip
  gzip
  curl
  unzip
  gimp
  # transmission_4-gtk #--(flatpak)
  isoimagewriter #
  clamav  #
  vdhcoapp #
  distrobox #
  gparted #
  bleachbit #
  rclone #
  onionshare #
  raider #--shredder--
  ventoy-full
  kdePackages.discover #--kde
  kdePackages.kclock #--kde
  plasma-browser-integration #--kde
  konsole #kde
  oxygen #kde
  kdePackages.kdeconnect-kde #--kde
  kdePackages.kdenlive #--kde
  nmap #--pt
  metasploit #--pt
  snort #--pt
  johnny #--pt
  social-engineer-toolkit #--pt
  sherlock #--pt
  # wireshark #
  # selinux-python # 
  # tor #--use docker container  
  # tor-browser #--use docker container
  # gnome.gnome-software
  # riseup-vpn #--vpn
  # calyx-vpn #--vpn
  # kronosnet #--vpn
  # keepassxc #--password manager
  ];

 } #----end
