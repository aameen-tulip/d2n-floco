{ config, ... }: {
  discoverers.floco = let
    name      = "floco";
    subsystem = "node";
  in {
    inherit name subsystem;
    discover  = { tree }: [
      ( config.dlib.construct.discoveredProject {
        inherit subsystem name;
        inherit (tree) relPath;
        translators   = ["floco"];
        subsystemInfo = {};
      } )
    ];
  };
}
