{inputs, username, ...}: {
  imports =
       [(import ./git.nix)]
     ++[(import ./hyprland.nix)]
     ++[(import ./kitty.nix)]
    # ++[(import ./gtk.nix)]
     ++[(import ./programs.nix)]
       ;   
}
