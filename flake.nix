{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil.url = "github:oxalica/nil";
    nix-index-database.url = "github:nix-community/nix-index-database";
    tvbeat-ssh.url = "github:janhencic/tvbeat-ssh";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nil, nix-index-database, tvbeat-ssh }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      nil = inputs.nil.packages.${system}.default;
    in {
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          system = "${system}";
          specialArgs = { inherit inputs pkgs-unstable tvbeat-ssh; };
          modules = [ ./hosts/pc ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          system = "${system}";
          specialArgs = { inherit inputs pkgs-unstable tvbeat-ssh; };
          modules = [ ./hosts/laptop ];
        };
      };

      homeConfigurations = {
        "janhencic@pc" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs pkgs-unstable; };
          modules = [ ./home/janhencic ];
        };
        "janhencic@tvb" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs pkgs-unstable; };
          modules = [ ./home/janhencic/minimal.nix ];
        };
      };

      devShell.${system} = with pkgs;
        mkShell {
          NIX_CONFIG =
            "extra-experimental-features = nix-command flakes repl-flake";
          nativeBuildInputs = [
            git
            home-manager.packages.${system}.default
            stylua
            nil
            pkgs.nixpkgs-fmt
          ];
        };

      # So I can inspect tham via nix repl
      inherit nixpkgs;
      inherit nixpkgs-unstable;
    };
}
