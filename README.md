# Agent Dance Homebrew Tap

Official Homebrew packages for Agent Dance projects.

## LUBAN Code

```bash
HOMEBREW_NO_INSTALL_CLEANUP=1 brew install agent-dance/tap/luban-code
```

The environment variable only skips Homebrew's unrelated global cleanup after
installation. Download verification and tap trust remain enabled.

Upgrade or uninstall with:

```bash
brew upgrade luban-code
brew uninstall luban-code
```

The Cask is generated from the latest immutable
[`agent-dance/luban`](https://github.com/agent-dance/luban/releases/latest)
release and its published SHA-256 checksums. The synchronization workflow uses
only this repository's scoped `GITHUB_TOKEN`.
