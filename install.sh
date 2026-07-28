#!/usr/bin/env bash

set -e

echo "=================================================="
echo "  Khôi phục Arch + Driver + Hyprland + Noctalia   "
echo "=================================================="

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Cài công cụ nền tảng
echo "[+] Cài đặt stow, zsh, git, base-devel..."
sudo pacman -S --needed --noconfirm stow zsh git base-devel

# 2. Cài Paru (AUR Helper)
if ! command -v paru &> /dev/null; then
    echo "[+] Đang cài đặt paru..."
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (cd /tmp/paru && makepkg -si --noconfirm)
    rm -rf /tmp/paru
fi

# 3. Cài Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "[+] Đang cài đặt Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 4. Cài đặt toàn bộ Driver & App từ Pacman
if [ -f "$DOTFILES_DIR/pkglist-native.txt" ]; then
    echo "[+] Đang cài các gói Pacman (Driver + Apps)..."
    sudo pacman -S --needed --noconfirm - < "$DOTFILES_DIR/pkglist-native.txt"
fi

# 5. Cài gói AUR (Bao gồm Noctalia V5)
if [ -f "$DOTFILES_DIR/pkglist-aur.txt" ]; then
    echo "[+] Đang cài các gói AUR qua Paru (noctalia-git)..."
    paru -S --needed --noconfirm - < "$DOTFILES_DIR/pkglist-aur.txt"
fi

# 6. Apply Dotfiles (GNU Stow)
echo "[+] Đang liên kết cấu hình (GNU Stow)..."
cd "$DOTFILES_DIR/stow"
for dir in */; do
    dir=${dir%/}
    stow -R -t "$HOME" "$dir"
done

# 7. Bật các System Services cho Driver & Phần cứng
echo "[+] Kích hoạt System Services (Mạng, Bluetooth, Audio)..."
sudo systemctl enable --now NetworkManager 2>/dev/null || true
sudo systemctl enable --now bluetooth 2>/dev/null || true

# 8. Chuyển Shell mặc định sang Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "[+] Đổi default shell sang Zsh..."
    chsh -s $(which zsh)
fi

echo "=================================================="
echo "    HOÀN TẤT! REBOOT HOẶC GÕ 'Hyprland' ĐỂ VÀO   "
echo "=================================================="
