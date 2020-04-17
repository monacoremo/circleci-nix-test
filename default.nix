let
    nixpkgsVersion =
      # Pinned version of Nixpkgs, generated with nixpkgs-update.
      {
        date = "2020-04-15";
        rev = "7e07846d99bed4bd7272b1626038e77a78aa36f6";
        tarballHash = "1dx82cj4pyjv1fdxbfqp0j7bpm869hyjyvnz57zi9pbp20awjzjr";
      };

  pinnedPkgs =
    builtins.fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${nixpkgsVersion.rev}.tar.gz";
      sha256 = nixpkgsVersion.tarballHash;
    };

  overlays = [
    (import nix/overlays/gitignore.nix)
    (import nix/overlays/haskell-packages { inherit compiler; })
  ];

  pkgs =
    import pinnedPkgs { inherit overlays; };
in
rec {
  inherit pkgs pinnedPkgs;
}
