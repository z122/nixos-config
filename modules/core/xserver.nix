{ pkgs, username, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    layout = "cn";
    xkbVariant = "";
  };

}
