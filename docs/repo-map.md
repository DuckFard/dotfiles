# Repository Map

This repository is a public, sanitized version of the workstation config. It
keeps reusable declarative config in Git and keeps generated state out.

## Top Level

- `nixos/` - NixOS flake, Home Manager module, system config, hardware template, and cursor assets.
- `config/` - user-level XDG config snapshots that are useful to read or reuse.
- `docs/` - maintenance notes for this repository.
- `scripts/` - local helper scripts for validation and tree inspection.

## Important Files

- `nixos/flake.nix` - entry point for the NixOS system.
- `nixos/home.nix` - Home Manager user packages, shell setup, Git placeholder identity, and cursor config.
- `nixos/hardware-configuration.nix` - hardware template with placeholder disk UUIDs.
- `config/driftwm/config.toml` - driftwm config, including NSO widget keybindings.
- `config/driftwm/nso.toml` - NSO widget override template.
- `config/waybar/config.mechabar.full.jsonc` - main Waybar layout snapshot.
- `scripts/check` - privacy scan plus Nix flake evaluation.

## Generated Or Private State

Do not commit browser profiles, app sessions, caches, secrets, real disk UUIDs,
real weather keys, or generated Home Manager symlinks. The root `.gitignore`
keeps the common ones out.
