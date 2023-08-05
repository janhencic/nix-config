{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }@inputs: {
    nixosConfigurations = {
      pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/pc ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/laptop ];
      };
    };

    homeConfigurations = {
      "janhencic@pc" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/janhencic ];
      };
      "janhencic@tvb" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/janhencic/minimal.nix ];
      };
    };

    devShell.x86_64-linux = with nixpkgs.legacyPackages."x86_64-linux"; mkShell {
      NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
      nativeBuildInputs = [
        git
        home-manager.packages.x86_64-linux.default
        stylua
      ];
    };
  };
}
