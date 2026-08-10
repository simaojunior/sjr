{
  description = "simaojunior.dev — Phoenix personal site (Nocturne fansite design)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11-small";
    elixir-overlay.url = "github:zoedsoupe/elixir-overlay";
  };

  outputs = {
    nixpkgs,
    elixir-overlay,
    ...
  }: let
    inherit (nixpkgs.lib) genAttrs;
    inherit (nixpkgs.lib.systems) flakeExposed;
    forAllSystems = f:
      genAttrs flakeExposed (system:
        f (import nixpkgs {
          inherit system;
          overlays = [elixir-overlay.overlays.default];
        }));
  in {
    devShells = forAllSystems (pkgs: let
      inherit (pkgs) mkShell;
      inherit (pkgs.beam.interpreters) erlang_28;
    in {
      default = mkShell {
        name = "sjr";
        packages = with pkgs;
          [(elixir-with-otp erlang_28).latest nodejs_24 flyctl]
          ++ lib.optionals stdenv.isLinux [inotify-tools]
          ++ lib.optionals stdenv.isDarwin [
            darwin.apple_sdk.frameworks.CoreServices
            darwin.apple_sdk.frameworks.CoreFoundation
          ];

        shellHook = ''
          echo "elixir $(elixir --version | tail -1 | cut -d' ' -f2) — 'mix setup' then 'mix phx.server' (http://localhost:4000)"
        '';
      };
    });

    formatter = forAllSystems (pkgs: pkgs.alejandra);
  };
}
