{
  description = ''
    Microservice to tooling of CX
  '';

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        exDev = pkgs.beam.packages.erlangR25.elixir;
      in {
        devShell = pkgs.mkShell {
          name = "orchestrator_cx_ms";
          buildInputs = with pkgs; [
            gnumake
            gcc
            readline
            openssl
            zlib
            libxml2
            curl
            libiconv
            # my elixir derivation
            exDev
            beamPackages.rebar3
            glibcLocales
          ] ++ pkgs.lib.optional stdenv.isLinux [
                inotify-tools
                # observer gtk engine
                gtk-engine-murrine
              ]
            ++ pkgs.lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
                CoreFoundation
                CoreServices
              ]);

         # define shell startup command
        shellHook = ''
          # create local tmp folders
          mkdir -p .nix-mix
          mkdir -p .nix-hex

          mix local.hex --force --if-missing
          mix local.rebar --force --if-missing

          # to not conflict with your host elixir
          # version and supress warnings about standard
          # libraries
          export ERL_LIBS="$HEX_HOME/lib/erlang/lib"
        '';
      };
    });
}