{ config, ... }: {
  translators.floco = { ... }: {
    type      = "pure";
    name      = "floco";
    subsystem = "node";
    translate = { ... }: {
      result = {
        _generic = {
          subsystem               = "node";
          defaultPackage          = "lodash";
          location                = "";
          sourcesAggregatedHash   = null;
          packages.lodash         = "4.17.21";
        };
        _subsystem                       = {};
        cyclicDependencies               = {};
        dependencies.lodash."4.17.21"    = [];
        sources.lodash."4.17.21".outputs = {
          fetched = narHash: builtins.fetchTree {
            type = "tarball";
            url  = "https://registry.npmjs.org/lodash/-/lodash-4.17.21.tgz";
            inherit narHash;
          };
          calcHash = _: "sha256-amyN064Yh6psvOfLgcpktd5dRNQStUYHHoIqiI6DMek=";
        };
      };
    };
  };
}
