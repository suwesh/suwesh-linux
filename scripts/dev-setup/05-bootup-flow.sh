cat << 'EOF' > scripts/dev-setup/05-boot-flow.sh
#!/usr/bin/env bash
set -euo pipefail

echo "=========================================================================="
echo "==> suwesh-linux Phase 5: Graphical Lock-on-Boot Architecture (Matching)"
echo "=========================================================================="

# 1. Configure systemd getty override for completely silent autologin to TTY1
echo "--> Configuring secure, hidden TTY1 autologin for user: suwesh..."
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/

cat << 'SYS_EOF' > /etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin suwesh --noclear %I $TERM
SYS_EOF

# 2. Inject environment autostart logic into the user's Zsh profile
echo "--> Injecting Wayland compositor hand-off rules into Zsh profile..."
TARGET_ZPROFILE="/home/suwesh/.zprofile"
mkdir -p "$(dirname "$TARGET_ZPROFILE")"

cat << 'ZSH_EOF' >> "$TARGET_ZPROFILE"

# suwesh-linux: Autostart Niri session seamlessly from secure TTY1 autologin
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR:-0}" -eq 1 ]; then
    exec niri --session
fi
ZSH_EOF

sudo chown suwesh:suwesh "$TARGET_ZPROFILE"

# 3. Inject immediate graphic lock directive (Matching your manual nano edit)
echo "--> Inserting pre-session lock command into Niri configuration..."
TARGET_NIRI_CONF="/home/suwesh/.config/niri/config.kdl"

# Using sed to cleanly insert your exact line right above the waybar trigger line
if [ -f "$TARGET_NIRI_CONF" ]; then
    sed -i '/spawn-at-startup "waybar"/i \    spawn-at-startup "hyprlock" "--immediate"' "$TARGET_NIRI_CONF"
fi

sudo chown -R suwesh:suwesh /home/suwesh/.config/

echo "=========================================================================="
echo "==> Secure Gatekeeper Lock-on-Boot Backup Formed Cleanly!"
echo "=========================================================================="
EOF
