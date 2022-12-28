{ config, ... }: let
in {
  builders.floco = { ... }: {
    name      = "floco";
    subsystem = "node";
    type      = "pure";
    build     = { getSource, ... }: {
      packages.lodash."4.17.21" = let
        system  = builtins.currentSystem or "aarch64-darwin";
        pkgsFor = (
          builtins.getFlake
            "github:NixOS/nixpkgs/95aeaf83c247b8f5aa561684317ecd860476fcd6"
        ).legacyPackages.${system};
        drv = derivation {
          name = "lodash-4.17.21";
          inherit (pkgsFor) system;
          builder = "${pkgsFor.bash}/bin/bash";
          PATH    = "${pkgsFor.coreutils}/bin";
          src     = getSource "lodash" "4.17.21";
          args    = ["-ec" "cp -pr --reflink=auto -- \"$src\" \"$out\";"];
          preferLocalBuild = true;
          allowSubstitutes =
            ( builtins.currentSystem or "unknow" ) != pkgsFor.system;
        };
      in drv // {
        overrideAttrs = _: drv;
      };
    };
  };
}
