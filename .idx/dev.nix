# To learn more about how to use Nix to configure your environment
# see: https://firebase.google.com/docs/studio/customize-workspace
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "unstable"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.zulu17
    pkgs.maven
  ];
  # Sets environment variables in the workspace
  env = {};

  # Sets the MySQL Service
  services = {
    docker ={
      enable = true;
    };
  };

  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "vscjava.vscode-java-pack"
      "rangav.vscode-thunder-client"
    ];
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        install = "./mvnw clean install -DskipTests";
      };
      # Runs when a workspace is (re)started
      onStart = {
        run-server = "PORT=3000 ./mvnw spring-boot:run";
      };
    };
  };
}