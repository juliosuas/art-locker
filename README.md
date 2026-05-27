# Art Locker

Experimental art-first lock screen for Linux/XFCE multi-monitor desktops.

Art Locker shows a museum-style artwork backdrop across all monitors, then
reveals a macOS-inspired acrylic login prompt when the user wakes the session.
It was built for an XFCE + X11 workstation with three monitors, including one
portrait display.

> Status: alpha. This is not ready to trust as your only lock screen.

## Why This Exists

Most Linux lockers are reliable but visually plain. Art Locker explores a
lock screen that feels calm, high-contrast, and personal while keeping the
desktop locked during idle. The current goal is to harden the locker so it can
survive real-world monitor sleep/wake, DPMS transitions, and multi-monitor
geometry changes.

## Current Features

- Fullscreen X11/Tk lock windows on every detected monitor.
- Primary-monitor login prompt with avatar, user name, and password field.
- Artwork-of-the-day integration with custom art directories or curator data.
- Side-monitor artwork signatures.
- Instance lock to prevent duplicate lockers.
- Refuses to start if X11 or monitor geometry is not ready.
- Refuses to continue if global keyboard/pointer grab fails.
- Local diagnostic log at `~/.local/share/art-locker/locker.log`.
- Killswitch file: `touch /tmp/art-locker-killswitch`.

## Known Risks

- The project is alpha and should be tested with another recovery path
  available, such as SSH, TTY access, or a physical console.
- Tk/X11 fullscreen behavior can be sensitive to compositors and window
  managers.
- DPMS and monitor wake timing can report unstable geometry during transitions.
- PAM behavior differs between distributions.
- This has been tested primarily on XFCE/X11, not Wayland.

## Requirements

- Linux with X11
- XFCE or another X11 desktop with `xrandr`
- Python 3
- Pillow
- pamela
- `xdpyinfo`
- `xautolock` if you want idle activation

Install Python dependencies:

```bash
python3 -m pip install --user Pillow pamela
```

On Debian/Ubuntu-like systems, package names are commonly:

```bash
sudo apt install x11-xserver-utils x11-utils xautolock python3-pil python3-pamela
```

## Quick Check

Run the non-invasive validation first:

```bash
./art-locker --check
```

Expected output:

```text
OK display ready; monitors=3; artwork=/path/to/artwork.jpg
```

## Preview

Preview mode opens a normal window and does not grab input or authenticate:

```bash
./art-locker --preview
```

Press any key or move the pointer inside the preview to reveal the login card.
Press `Return` or `Esc` to exit preview.

## Manual Fullscreen Test

Before testing fullscreen, keep a recovery path available. In another terminal
or over SSH, prepare the killswitch command:

```bash
touch /tmp/art-locker-killswitch
```

Then run:

```bash
./art-locker
```

If anything goes wrong, create the killswitch file from another terminal.

## Idle Activation

Do not enable idle activation until fullscreen testing is clean.

An example disabled autostart file is provided in:

```text
examples/art-idle.desktop
```

To enable later, copy it to `~/.config/autostart/`, change:

```ini
Hidden=false
X-GNOME-Autostart-enabled=true
```

and make sure the `Exec=` path points to your installed `art-locker`.

## Design Direction

The login prompt is intentionally closer to macOS than to a traditional Linux
dialog:

- centered avatar
- user display name
- single password field
- quiet acrylic treatment over the artwork
- minimal status text

The lock screen should feel polished, but reliability comes first.

## Community Help Wanted

The main areas where help is needed:

- robust DPMS sleep/wake handling
- safer X11 grab behavior across window managers
- cleaner PAM integration across distributions
- screenshots and reports from different monitor layouts
- accessibility review for contrast, keyboard flow, and font scaling
- Wayland feasibility research

Please include desktop environment, window manager, GPU, driver, monitor layout,
and relevant logs when reporting bugs.

## License

MIT
