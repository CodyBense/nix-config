{
  description = "my nixos configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:Nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixarr = {
      url = "github:rasmus-kirk/nixarr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "cody";
      overlays = [
      ];
    in
    {
      nixosConfigurations = {
        "revan" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
            inherit username;
          };
          modules = [
            ./hosts/revan/configuration.nix
            ./modules/desktop/noctalia.nix
            inputs.sops-nix.nixosModules.sops
            inputs.agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit username;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users."cody" = ./modules/home-manager;
            }
          ];
        };
      };
      nixosConfigurations = {
        "pikachu" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
            inherit username;
          };
          modules = [
            ./hosts/pikachu/configuration.nix
            inputs.sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            inputs.nixarr.nixosModules.default
            inputs.agenix.nixosModules.default
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit username;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${username} = ./modules/home-manager;
            }
          ];
        };
      };
    };
}
