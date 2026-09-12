cat << 'EOF' > dev-setup/03-user-env.sh
#!/usr/bin/env bash
set -euo pipefail

echo "==> Updating package database..."
sudo pacman -Syu --noconfirm

echo "==> Installing VirtualBox Guest Additions..."
sudo pacman -S --noconfirm virtualbox-guest-utils
sudo systemctl enable --now vboxservice

echo "==> Installing core developer tools..."
sudo pacman -S --noconfirm \
    base-devel \
    git \
    neovim \
    zsh \
    curl \
    wget \
    unzip \
    tar \
    btop \
    openssh

echo "==> Changing default shell to Zsh for user ${USER}..."
sudo chsh -s /usr/bin/zsh "${USER}"

echo "==> Phase 3 User Environment Setup Complete!"
EOF
