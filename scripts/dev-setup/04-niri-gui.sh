cat << 'EOF' > dev-setup/04-gui-niri.sh
#!/usr/bin/env bash
set -euo pipefail

echo "=========================================================================="
echo "==> suwesh-linux Phase 4: Installing Custom Niri & Wayland GUI Stack"
echo "=========================================================================="

# 1. Core Graphics Stack (Optimized for Modern Mesa Render / VMSVGA 3D)
echo "--> Installing core graphics acceleration stack..."
sudo pacman -S --noconfirm mesa

# 2. Base Compositor & Visual Layout Stack
echo "--> Installing Niri compositor, layout engines, and system managers..."
sudo pacman -S --noconfirm \
    niri \
    xorg-xwayland \
    waybar \
    fuzzel \
    swaync \
    hyprlock \
    hypridle \
    pipewire \
    pipewire-pulse \
    wireplumber \
    networkmanager \
    playerctl \
    swaybg

# 3. High-Performance Terminal & Theme Fonts (User Choice Core)
echo "--> Installing GPU-accelerated terminal and design fonts..."
sudo pacman -S --noconfirm \
    kitty \
    ttf-jetbrains-mono-nerd \
    otf-font-awesome

# 4. Initialize User Rice Blueprint Directories
echo "--> Pre-building hidden system configuration structures..."
mkdir -p "$HOME/.config/niri" \
         "$HOME/.config/waybar" \
         "$HOME/.config/fuzzel" \
         "$HOME/.config/swaync" \
         "$HOME/.config/hypr" \
         "$HOME/.config/kitty"

# 5. Bootstrap Niri Keybindings Master Template
if [ ! -f "$HOME/.config/niri/config.kdl" ]; then
    echo "--> Deploying baseline Niri layout template..."
    cp /usr/share/doc/niri/default-config.kdl "$HOME/.config/niri/config.kdl"
fi

echo "=========================================================================="
echo "==> UI Architecture Layer Successfully Built for suwesh-linux!"
echo "=========================================================================="
EOF
