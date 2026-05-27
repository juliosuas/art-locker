#!/usr/bin/env bash
set -euo pipefail

install -Dm755 art-locker "$HOME/.local/bin/art-locker"
install -Dm644 examples/art-idle.desktop "$HOME/.config/autostart/art-idle.desktop"

echo "Installed art-locker to $HOME/.local/bin/art-locker"
echo "Installed disabled autostart file to $HOME/.config/autostart/art-idle.desktop"
echo "Run: art-locker --check"
