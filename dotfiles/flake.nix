{
  description = "Dotfiles for accme's configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  zen-browser = {
    url = "github:youwen5/zen-browser-flake";
    # optional, but recommended if you closely follow NixOS unstable so it shares
    # system libraries, and improves startup time
    # NOTE: if you experience a build failure with Zen, the first thing to check is to remove this line!
    inputs.nixpkgs.follows = "nixpkgs";
    };
  };

   ayugram-desktop = {
      type = "git";
      submodules = true;
      url = "https://github.com/ndfined-crp/ayugram-desktop/";
     };
  };


  outputs = inputs@{ self, nixpkgs, home-manager, stylix, zen-browser }:{
    nixosConfigurations = {
      "cr0w0" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager

          ./hosts/7950x3d-xtx/default.nix
          ./hosts/7950x3d-xtx/packages.nix

          {
            home-manager = {
              useGlobalPkgs = false;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.cr0w0 = {
                imports = [
                  ./hosts/7950x3d-xtx/home.nix
                  ./modules/home-manager/theme/default.nix
                  ./modules/home-manager/gtk/default.nix
                  ./modules/home-manager/qt/default.nix
                  ./modules/home-manager/waybar/default.nix
                  ./modules/home-manager/mako/default.nix
                  ./modules/home-manager/mangohud/default.nix
                  ./modules/home-manager/rofi/default.nix
                  ./modules/home-manager/hyprland/default.nix
                  ./modules/home-manager/hyprlock/default.nix
                  ./modules/home-manager/hypridle/default.nix
                  ./modules/home-manager/hyprpaper/default.nix
                  ./modules/home-manager/nvim/default.nix
                  ./modules/home-manager/kitty/default.nix
                  ./modules/home-manager/tmux/default.nix
                  ./modules/home-manager/yazi/default.nix
                  ./modules/home-manager/starship/default.nix
                  ./modules/home-manager/zsh/default.nix
                  ./modules/home-manager/fastfetch/default.nix


                  stylix.homeModules.stylix
                  ./modules/home-manager/stylix/default.nix
                ];
              };
            };
          }
        ];
      };


      };
    };
  };
}
