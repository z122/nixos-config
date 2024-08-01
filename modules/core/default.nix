{ inputs, nixpkgs, self, username, ...}:
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
in
{
  nixos = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit self inputs username pkgs; };
    modules =
      [ (import ./../../hosts/nixos/hardware-configuration.nix) ]
      ++ [ (import ./bootloader.nix) ]
      ++ [ (import ./xserver.nix) ]
      ++ [ (import ./network.nix) ]
      ++ [ (import ./services.nix) ]
      ++ [ (import ./system.nix) ]
      ++ [ (import ./user.nix) ]
      ++ [ (import ./nvidia.nix) ]
      ++ [ (import ./program.nix) ]
      ++ [ (import ./xserver.nix) ] 
      ++ [ (import ./security.nix) ]
      ++ [ (import ./display-manager.nix) ]
      ++ [ (import ./theme.nix) ]
    ;
  };
}
