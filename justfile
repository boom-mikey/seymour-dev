system := "x86_64-linux"
nix-version := "2.19.2"
nix-release-url := quote(
  "https://releases.nixos.org/nix"
    / "nix-" + nix-version
    / "nix-" + nix-version + "-" + system + ".tar.xz"
)
nix-config-path := env("HOME") / ".config" / "nix"
has-nix := path_exists("/nix")

# list recipes
default:
  @just --list

# print the url of the nix release to install
nix-release:
  @echo {{nix-release-url}}
  @echo "'/nix' exists: {{has-nix}}"

# init local nix config
nix-init-config:
  @mkdir -p {{nix-config-path}}
  @cp --update=none "./config/nix/nix.conf" {{nix-config-path}}

# install nix
nix-install: nix-init-config
  cd $(mktemp -d) \
    && curl -LO {{nix-release-url}} \
    && tar xJf "nix-{{nix-version}}-{{system}}.tar.xz" \
    && cd "nix-{{nix-version}}-{{system}}" \
    && ./install --daemon

# enter ros dev shell
shell:
  @nix develop
