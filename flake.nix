{
  description = "testing ros on nix";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    ros-flake.url = "github:lopsided98/nix-ros-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, ros-flake }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
          ros = ros-flake.legacyPackages.${system}.jazzy;
      in
      {
        devShell = pkgs.mkShell {
          nativeBuildInputs = [
            (buildEnv {
              paths = [
                ros-core
                colcon
                geometry-msgs
                turtlebot4-desktop
                turtlebot4-simulator
                slam-toolbox
                nav2-minimal-tb4-sim
                nav2-minimal-tb3-sim
                # rqt metapackages
                rqt-common-plugins
                rqt-tf-tree
                tf2-tools
              ];
            })
          ];
        };
      }
    );
}
