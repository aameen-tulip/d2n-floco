{ config, ... }: let
  pkgsFor = config.pkgs;
in {
  builders.floco = { ... }: {
    name      = "floco";
    subsystem = "node";
    type      = "pure";
    build     = { getSource, ... }: {
      packages.lodash."4.17.21" = let
        drv = derivation {
          name = "lodash-4.17.21";
          inherit (pkgsFor) system;
          builder = "${pkgsFor.bash}/bin/bash";
          PATH    = "${pkgsFor.coreutils}/bin";
          src     = getSource "lodash" "4.17.21";
          args    = ["-ec" "cp -pr --reflink=auto -- \"$src\" \"$out\";"];
          preferLocalBuild = true;
          allowSubstitutes =
            ( builtins.currentSystem or "unknown" ) != pkgsFor.system;
        };
      in drv // {
        overrideAttrs = _: drv;
      };
    };
  };
}
