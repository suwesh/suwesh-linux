cat << 'EOF' > scripts/dev-setup/06-compositor-layout.sh
#!/usr/bin/env bash
set -euo pipefail

echo "==> suwesh-linux Phase 6: Injecting Niri Compositor Layout Rules..."

TARGET_NIRI_CONF="/home/suwesh/.config/niri/config.kdl"

if [ -f "$TARGET_NIRI_CONF" ]; then
    # Enable Android-style panning camera view
    sed -i 's/# center-focused-column "never"/center-focused-column "on-overflow"/' "$TARGET_NIRI_CONF"
fi

sudo chown -R suwesh:suwesh /home/suwesh/.config/
echo "==> Phase 6 Compositor Layout Configuration Locked Natively!"
EOF

chmod +x scripts/dev-setup/06-compositor-layout.sh
