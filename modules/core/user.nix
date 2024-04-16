{ pkgs, inputs, username, ...}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username; };
    users.${username} = {
      imports = [ (import ./../home) ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDF/Wk4OTU52BI+LOQkr1RH7rqsSyNewS37FGYdte7UrhYPA8pNPRZgHLdB7BHDg/GvgYEVkEkN9JWqzIxDY1TjtZb2kefIdjcJ92pb+n62K4m/IxNJuU+kRV1CZ26xfS3TZAsBbXj3nWtNrIXcCqWS5TVEANMwrNRYEf0eUDpVxQPKrlL7MRXBR8i2Ds2I8SraC/9V/7kCPtUXzkqyVptPTX0i4DtHrfvw/IPrGeDAhOKdC4Bou11ANayfa+e8z4M41WbVgA0yLkgUvd/5lb7yIHb9WRXsyheeitfVzHP0vKxJC/HO4KaPdJ6rkeEU21t6uF17fhGKIuvIJmpSBnvK2xIPGfxGm/RGYJQB+sk59NVypZYBZdcsgVXG+CtHuEWNNAotTI+xNvpTZmuIvKl9ttSltWJG0+3DFzPsOiPCsIXj3dQNGSg9anDPQke2Pm+CCiV9cl62FQq5+Ggas5WkMhKQRE5VUje1szwW+6Bl3raxtA/1Uw8WUFcZiMd2C3U= tieto"
    ];
  };
}
