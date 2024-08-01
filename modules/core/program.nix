{ pkgs, ...}:
{
  programs.dconf.enable = true; # hyprland need 
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    gparted
    nix-output-monitor
    python3
    nix-index
    firefox
  ];
}
