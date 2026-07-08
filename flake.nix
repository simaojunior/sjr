{
  description = "simaojunior.com — Zola static site (zola-hacker theme)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11-small";
  };

  outputs = {
    nixpkgs,
    ...
  }: let
    inherit (nixpkgs.lib) genAttrs;
    inherit (nixpkgs.lib.systems) flakeExposed;
    forAllSystems = f:
      genAttrs flakeExposed (system:
        f (import nixpkgs {inherit system;}));
  in {
    devShells = forAllSystems (pkgs: let
      inherit (pkgs) mkShell;
    in {
      default = mkShell {
        name = "simaojunior.com";
        packages = with pkgs; [
          zola
          git
          wrangler # Cloudflare Pages deploys
        ];

        shellHook = ''
          echo "zola $(zola --version | cut -d' ' -f2) — 'zola serve' to preview, 'zola build' + 'wrangler pages deploy public' to ship"
        '';
      };
    });

    formatter = forAllSystems (pkgs: pkgs.alejandra);
  };
}
