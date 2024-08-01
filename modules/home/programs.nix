# if program have config should move to single file 
{ pkgs, ... }:
{
    programs.fish.enable = true;
    home.packages = with pkgs; [
        hyprland
        pyprland
        hyprpicker
        hyprcursor
        hyprlock
        hypridle
        hyprpaper
        waybar

        dunst

        avizo

        rofi-wayland

        starship
        
        vscode
        neovim
        # vscode
        # helix

        # qutebrowser
        # zathura
        # mpv
        # imv
    ];
}
