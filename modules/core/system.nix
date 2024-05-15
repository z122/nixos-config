{ self, pkgs, lib, inputs, ...}:
let
  verilator5008 = pkgs.verilator.overrideAttrs (
    oldAttrs: rec {
      pname = "verilator";
      version = "5.008";

      src = pkgs.fetchFromGitHub {
        owner = pname;
        repo = pname;
        rev = "v${version}";
        hash = "sha256-+eJBGvQOk5w+PyUF3aieuXZVeKNS4cKQqHnJibKwFnM=";
      };
      patches = [];
      enableParallelBuilding = true;
      buildInputs = [ pkgs.perl ];
      nativeBuildInputs = with pkgs; [ makeWrapper flex bison python3 autoconf help2man ];
      nativeCheckInputs = [ pkgs.which ];
      doCheck = pkgs.stdenv.isLinux; # darwin tests are broken for now...
      checkTarget = "test";
      preConfigure = "autoconf";
      postPatch = ''
        patchShebangs bin/* src/{flexfix,vlcovgen} test_regress/{driver.pl,t/*.pl}
      '';
      postInstall = lib.optionalString pkgs.stdenv.isLinux ''
        for x in $(ls $out/bin/verilator*); do
          wrapProgram "$x" --set LOCALE_ARCHIVE "${pkgs.glibcLocales}/lib/locale/locale-archive"
        done
      '';
      meta = with lib; {
        description = "Fast and robust (System)Verilog simulator/compiler";
        homepage    = "https://www.veripool.org/wiki/verilator";
        license     = with licenses; [ lgpl3Only artistic2 ];
        platforms   = platforms.unix;
        maintainers = with maintainers; [ thoughtpolice ];
      };
    }
  );
in 
{
  # imports = [ inputs.nix-gaming.nixosModules.default ];
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    open-vm-tools
    gparted
    gnumake
    gcc
    gdb
    ccache
    gdbgui
    nix-output-monitor
    vscode 
    verilator5008
    gtkwave
    python3
    gnomeExtensions.paperwm
  ];

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";
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

  nixpkgs.config.allowUnfree = true;
  
  system.stateVersion = "23.11";
}
