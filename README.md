# NixOS + Driftwm Dotfiles

Public NixOS + driftwm workstation setup.

This repo is meant to show the active configuration rather than provide a
generic installer. It includes the declarative NixOS/Home Manager config,
driftwm config, Waybar setup, Home Manager shell/package config, GTK/font/portal settings,
and cursor assets referenced by the Nix config.

## Layout

- `nixos/` - NixOS flake, system config, Home Manager config, lock file, hardware config, and cursor assets.
- `config/driftwm/` - active driftwm config plus NSO widget overrides.
- `config/waybar/` - active Waybar theme, modules, and helper scripts.
- `nixos/home.nix` - user packages, Git identity, zsh setup, shell aliases, and cursor config.
- `config/gtk-*`, `config/fontconfig/`, `config/xsettingsd/`, `config/xdg-desktop-portal-wlr/` - desktop integration config.
- `docs/` - restore, privacy, and repository map notes.
- `scripts/` - local maintenance helpers.

More detail is in `docs/repo-map.md`.

## Driftwm Source

The NixOS flake points at a public driftwm source:

```nix
driftwm.url = "github:DuckFard/driftwm";
```

That checkout includes the NSO widget-suite integration commit:

```text
0c29766 Add integrated NSO widget suite
```

For another machine, replace that source with your own checkout or fork if you
want to change driftwm itself.

## Apply Locally

From this repo, the current host can be rebuilt with:

```sh
sudo nixos-rebuild switch --flake ./nixos
```

For a fresh machine, review `nixos/hardware-configuration.nix`,
`nixos/configuration.nix`, and `nixos/home.nix` before rebuilding. The hardware
file intentionally uses placeholder disk UUIDs; replace them with values from
your machine.

The default public placeholders are configured in `nixos/flake.nix`:

```nix
userName = "nixos-user";
userEmail = "replace-me";
hostName = "nixos";
```

## Maintenance

Run the standard checks before pushing:

```sh
./scripts/check
```

Useful helpers:

```sh
./scripts/tree                # show tracked files in a compact tree-like view
./scripts/check-private-info  # scan tracked files for private-info patterns
nix flake check --no-build ./nixos
```

The restore point from before the repository cleanup is documented in
`docs/restore.md`.

## NSO Widgets

The driftwm config is set up for the native NSO widget port under driftwm. The
user config lives at:

```text
config/driftwm/nso.toml
```

Weather uses OpenWeatherMap-compatible keys from the upstream Rainmeter skin:
`LocationCode` and `ApiKey`. The published config keeps placeholders; do not
commit a live API key.

## Public Repo Notes

This snapshot intentionally excludes browser profiles, app session state,
caches, credentials, generated runtime state, personal usernames, personal
email addresses, local home paths, and real disk UUIDs.
