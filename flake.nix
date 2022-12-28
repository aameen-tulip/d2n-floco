{
  inputs.dream2nix.url = "github:nix-community/dream2nix";

  outputs = { self, dream2nix, ... } @ inputs:
    ( dream2nix.lib.makeFlakeOutputs {
      systems = [
        "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"
      ];
      config.projectRoot = ./.;
      config.modules = [
        ./discoverers.nix
        ./translators.nix
        ./builders.nix
      ];
      source = ./.;
      # The dummy discoverer will discover a project `hello` automatically.
      autoProjects = true;
    } ) // {
      checks.x86_64-linux.hello   = self.packages.x86_64-linux.hello;
      checks.aarch64-linux.hello  = self.packages.aarch64-linux.hello;
      checks.x86_64-darwin.hello  = self.packages.x86_64-darwin.hello;
      checks.aarch64-darwin.hello = self.packages.aarch64-darwin.hello;
    };
}
