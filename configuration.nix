# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
    ];

  services.vscode-server.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

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
  i18n.defaultLocale = "zh_CN.UTF-8";

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

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    layout = "cn";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tggpx = {
    isNormalUser = true;
    description = "tggpx";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDF/Wk4OTU52BI+LOQkr1RH7rqsSyNewS37FGYdte7UrhYPA8pNPRZgHLdB7BHDg/GvgYEVkEkN9JWqzIxDY1TjtZb2kefIdjcJ92pb+n62K4m/IxNJuU+kRV1CZ26xfS3TZAsBbXj3nWtNrIXcCqWS5TVEANMwrNRYEf0eUDpVxQPKrlL7MRXBR8i2Ds2I8SraC/9V/7kCPtUXzkqyVptPTX0i4DtHrfvw/IPrGeDAhOKdC4Bou11ANayfa+e8z4M41WbVgA0yLkgUvd/5lb7yIHb9WRXsyheeitfVzHP0vKxJC/HO4KaPdJ6rkeEU21t6uF17fhGKIuvIJmpSBnvK2xIPGfxGm/RGYJQB+sk59NVypZYBZdcsgVXG+CtHuEWNNAotTI+xNvpTZmuIvKl9ttSltWJG0+3DFzPsOiPCsIXj3dQNGSg9anDPQke2Pm+CCiV9cl62FQq5+Ggas5WkMhKQRE5VUje1szwW+6Bl3raxtA/1Uw8WUFcZiMd2C3U= tieto"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    open-vm-tools
    gparted
    gnumake
    gcc
    gdb
    # bison
    # flex
    # SDL2
  ];

  services.openssh = {
    enable = true;
  };


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
  system.stateVersion = "23.11"; # Did you read the comment?

}
