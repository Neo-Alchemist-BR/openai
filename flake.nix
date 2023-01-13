{
  description = "OpenAI wrapper made in Elixir";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        elixir_overlay = (self: super: rec {
          erlang = super.erlangR25;
          beamPackages = super.beam.packagesWith erlang;
          elixir = beamPackages.elixir.override {
            version = "1.14.2";
            sha256 = "sha256-ABS+tXWm0vP3jb4ixWSi84Ltya7LHAuEkGMuAoZqHPA=";
          };
          hex = beamPackages.hex.override { inherit elixir;};
          rebar3 = beamPackages.rebar3;
          buildMix = super.beam.packages.erlang.buildMix'.override { inherit elixir erlang hex; };
        }
        );

        inherit (nixpkgs.lib) optional;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ elixir_overlay ];
        };

      in
      with pkgs;
      rec  {
        devShell =
          mkShell {
            name = "openai_elixir-shell";

            buildInputs = [
              glibcLocalesUtf8
              elixir
            ] ++ lib.optionals stdenv.isLinux
                [
                libnotify # For ExUnit Notifier on Linux.
                inotify-tools # For file_system on Linux.
                ]
              ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks;
                [
                terminal-notifier # For ExUnit Notifier on macOS.
                CoreFoundation CoreServices # For file_system on macOS.
                ]);

          # Fixes locale issue on `nix-shell --pure` (at least on NixOS). See
          # + https://github.com/NixOS/nix/issues/318#issuecomment-52986702
          # + http://lists.linuxfromscratch.org/pipermail/lfs-support/2004-June/023900.html
          # export LC_ALL=en_US.UTF-8
          LOCALE_ARCHIVE = if pkgs.stdenv.isLinux then "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive" else "";
          };

      }
    );

}
