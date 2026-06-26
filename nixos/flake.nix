{
  description = "NixOS config with driftwm";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    driftwm.url = "github:DuckFard/driftwm";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, driftwm, home-manager, ... }:
    let
      system = "x86_64-linux";
      userName = "nixos-user";
      userEmail = "replace-me";
      hostName = "nixos";
      driftwmPackage = driftwm.packages.${system}.default;
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit driftwmPackage userName userEmail hostName; };

        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = { inherit userName userEmail; };

            home-manager.users.${userName} = import ./home.nix;
          }
        ];
      };
    };
}
