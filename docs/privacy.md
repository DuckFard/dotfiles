# Public Privacy Policy

This repo is public. Keep it useful without publishing private machine state.

## Do Not Commit

- Real API keys, tokens, passwords, cookies, private keys, or `.env` files.
- Browser profiles, app session data, caches, crash dumps, or history files.
- Real disk UUIDs from `hardware-configuration.nix`.
- Personal home paths such as `/home/<name>`.
- Personal email addresses unless you intentionally want them public.
- Generated Home Manager symlinks under `.config`.

## Before Pushing

Run:

```sh
./scripts/check
```

That runs the tracked-file privacy scan and `nix flake check --no-build` for the
NixOS flake.

On a rebuilt target machine, also run:

```sh
./scripts/check-runtime-deps
```

That checks the runtime commands used by the driftwm and Waybar helpers without
requiring any private local paths.

## Weather Config

`config/driftwm/nso.toml` intentionally keeps placeholder OpenWeatherMap values:

```toml
LocationCode = "Paste Here!"
ApiKey = "Paste Here!"
```

Use real values only in your live local config, not in this repository.
