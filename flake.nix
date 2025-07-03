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
          buildInputs = [ ros.turtlesim
                          ros.ros2run
                          ros.rmw-fastrtps-dynamic-cpp ];
          RMW_IMPLEMENTATION = "rmw_fastrtps_dynamic_cpp";
        };
      }
    );
}
