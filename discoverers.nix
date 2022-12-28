{ config, ... }: {
  discoverers.dummy = let
    name      = "dummy";
    subsystem = "hello";
  in {
    inherit name subsystem;
    discover  = { tree }: [
      ( config.dlib.construct.discoveredProject {
        inherit subsystem name;
        inherit (tree) relPath;
        translators   = ["dummy"];
        subsystemInfo = {};
      } )
    ];
  };
}
