# Harden monitor sleep/wake and fullscreen lock reliability

Monet Locker is currently alpha. We are looking for help making it reliable
across real-world XFCE/X11 multi-monitor setups.

## Context

The locker was built for a three-monitor XFCE/X11 workstation:

- HDMI monitor on the left
- primary 4K monitor in the center
- portrait monitor on the right

The most fragile flow is idle lock plus monitor sleep/wake:

1. `xautolock` launches the locker after idle time.
2. XFCE/DPMS later blanks or sleeps the monitors.
3. The user wakes the machine.
4. The locker must keep correct monitor geometry, focus, and input grab.

## Known Problems To Investigate

- Monitor geometry can be unstable during DPMS wake.
- Fullscreen Tk windows can appear on wrong monitor coordinates if X reports a
  transient layout.
- The locker must fail closed or abort cleanly if global grab cannot be
  acquired.
- PAM behavior differs by distro; `pam_setcred` is intentionally avoided.
- The UI needs more testing with different scaling, font availability, and
  portrait monitor layouts.

## Current Safety Work

- Single-instance lockfile.
- X11 readiness check before starting.
- Repeated monitor detection before using geometry.
- Abort if no usable monitor layout exists.
- Abort if global grab fails.
- Killswitch at `/tmp/monet-locker-v2-killswitch`.
- Local log at `~/.local/share/monet-locker-v2/locker.log`.

## Help Wanted

Please test and report:

- distro and version
- desktop environment and window manager
- X11 vs Wayland
- GPU and driver
- output of `xrandr --listmonitors`
- DPMS settings from `xset q`
- whether lock, blank, sleep, wake, and unlock worked
- screenshots if geometry or UI is wrong
- relevant `~/.local/share/monet-locker-v2/locker.log` lines

## Acceptance Criteria

- The locker never leaves the user with an unusable black or misplaced screen.
- It never proceeds without a confirmed global grab.
- It never launches duplicate lock windows.
- It handles monitor wake without corrupting layout.
- It can be disabled safely and predictably.
