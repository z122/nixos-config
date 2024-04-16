{
  description = "tggpx's nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";

  };

  outputs = { nixpkgs, self, ...} @ inputs:
    let
      username = "tggpx";
    in
    {
      nixosConfigurations = import ./modules/core/default.nix {
        inherit self nixpkgs inputs username;
      };
    };
}
