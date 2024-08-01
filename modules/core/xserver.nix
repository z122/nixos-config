{ pkgs, username, ... }: 
{
    services.xserver = {
        enable = true;
    };

    services.libinput.enable = true;

}