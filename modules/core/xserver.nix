{ pkgs, username, ... }:
{
  services.xserver = {
    enable = true;
#    displayManager.sddm.enable = true;
#    displayManager.sddm.enableHidpi = true;
#    displayManager.sddm.settings = {
#        XDispaly = {
#            ServerArguments = "-nolisten tcp -dpi 96 -screen 2560*1440";
#        };
#    };
#    desktopManager.plasma6.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    layout = "cn";
    xkbVariant = "";
  };

}
