# Driftwm Source

This setup uses the public driftwm source configured in `nixos/flake.nix`.

The relevant local commit is:

```text
0c29766 Add integrated NSO widget suite
```

That commit integrates the NEEDY STREAMER OVERLOAD-inspired native widget suite
into driftwm under `extras/nso/`, adds Nix packaging, and documents the widget
config/rules.

Replace that source with your own fork or checkout path when reusing this
config.
