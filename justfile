system := "x86_64-linux"
nix-version := "2.19.2"
nix-release-url := quote(
  "https://releases.nixos.org/nix"
    / "nix-" + nix-version
    / "nix-" + nix-version + "-" + system + ".tar.xz"
)
has-nix := path_exists("/nix")

# list recipes
default:
  @just --list

# print the url of the nix release to install
nix-release:
  @echo {{nix-release-url}}
  echo "'/nix' exists: {{has-nix}}"

# install nix
nix-install:
  cd $(mktemp -d) \
    && curl -LO {{nix-release-url}} \
    && tar xJf "nix-{{nix-version}}-{{system}}.tar.xz" \
    && cd "nix-{{nix-version}}-{{system}}" \
    && ./install --daemon
