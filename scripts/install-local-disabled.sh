#!/usr/bin/env bash
set -euo pipefail

install -Dm755 monet-locker "$HOME/.local/bin/monet-locker"
install -Dm644 examples/monet-idle-v2.desktop "$HOME/.config/autostart/monet-idle-v2.desktop"

echo "Installed monet-locker to $HOME/.local/bin/monet-locker"
echo "Installed disabled autostart file to $HOME/.config/autostart/monet-idle-v2.desktop"
echo "Run: monet-locker --check"
