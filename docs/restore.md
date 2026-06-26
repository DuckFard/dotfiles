# Restore Points

The cleanup started from this shared restore tag in both public repositories:

```text
restore-2026-06-27-clean-public-state
```

## Inspect The Restore Point

```sh
git show --stat restore-2026-06-27-clean-public-state
```

## Temporarily Check It Out

```sh
git switch --detach restore-2026-06-27-clean-public-state
```

Return to normal work:

```sh
git switch main
```

## Revert The Branch To The Restore Point

This rewrites local branch history, so only use it when you intentionally want
to throw away commits after the restore point.

```sh
git switch main
git reset --hard restore-2026-06-27-clean-public-state
git push --force-with-lease origin main
```

For the driftwm repository, use the `public` remote if that is the configured
public remote:

```sh
git push --force-with-lease public main
```
