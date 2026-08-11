#!/usr/bin/env bash

# Thoát ngay nếu gặp lỗi
set -e

# --- CẤU HÌNH MÀU SẮC & BIỂU TƯỢNG ---
BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Hàm in tiêu đề bước
step() {
    echo -e "\n${BOLD}${CYAN}──── [ $1 ] ──────────────────────────────────────────${NC}"
}

info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

success() {
    echo -e "${GREEN}✔${NC} $1"
}

warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✖ $1${NC}"
    exit 1
}

# Bẫy lỗi nếu script sập giữa chừng
trap 'error "Cài đặt thất bại tại dòng $LINENO! Vui lòng kiểm tra log phía trên."' ERR

# --- BANNER CHÍNH ---
clear
echo -e "${PURPLE}${BOLD}"
cat << "EOF"
  ██╗  ██╗██╗██╗██████╗  ██████╗████████╗█████╗ ██╗     ██╗██╗█████╗ 
  ██║  ██║╚██╗██║██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██║     ██║██║██╔══██╗
  ███████║ ╚████║██████╔╝██║        ██║   ███████║██║     ██║██║███████║
  ██╔══██║  ╚██╔╝██╔══██╗██║        ██║   ██╔══██║██║     ██║██║██╔══██║
  ██║  ██║   ██║ ██║  ██║╚██████╗   ██║   ██║  ██║███████╗██║██║██║  ██║
  ╚═╝  ╚═╝   ╚═╝ ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝╚═╝╚═╝  ╚═╝
EOF
echo -e "       ${CYAN}Arch Linux + Hyprland + Noctalia V5 Auto Restorer${NC}"
echo -e "${PURPLE}───────────────────────────────────────────────────────────────${NC}\n"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. BẮT ĐẦU CÀI ĐẶT
step "1/8: Cài đặt công cụ nền tảng"
info "Đang cài stow, zsh, git, base-devel..."
sudo pacman -S --needed --noconfirm stow zsh git base-devel > /dev/null
success "Hoàn tất cài đặt công cụ nền tảng!"

step "2/8: Kiểm tra & Cài đặt Paru (AUR Helper)"
if ! command -v paru &> /dev/null; then
    info "Chưa tìm thấy Paru, tiến hành build từ AUR..."
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (cd /tmp/paru && makepkg -si --noconfirm)
    rm -rf /tmp/paru
    success "Đã cài đặt Paru thành công!"
else
    success "Paru đã sẵn sàng!"
fi

step "3/8: Kiểm tra Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Đang cài đặt Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    success "Đã cài đặt Oh My Zsh!"
else
    success "Oh My Zsh đã tồn tại!"
fi

step "4/8: Cài đặt Packages từ Pacman (Native)"
if [ -f "$DOTFILES_DIR/pkglist-native.txt" ]; then
    info "Đang cài đặt các gói hệ thống & driver..."
    sudo pacman -S --needed --noconfirm - < "$DOTFILES_DIR/pkglist-native.txt"
    success "Đã cài xong toàn bộ Native Packages!"
else
    warn "Không tìm thấy pkglist-native.txt, bỏ qua..."
fi

step "5/8: Cài đặt Packages từ AUR (Paru & Noctalia V5)"
if [ -f "$DOTFILES_DIR/pkglist-aur.txt" ]; then
    info "Tự động làm sạch gói -debug..."
    sed -i '/-debug/d' "$DOTFILES_DIR/pkglist-aur.txt"
    
    info "Đang biên dịch & cài đặt gói AUR..."
    paru -S --needed --noconfirm - < "$DOTFILES_DIR/pkglist-aur.txt"
    success "Đã cài xong toàn bộ AUR Packages!"
else
    warn "Không tìm me thấy pkglist-aur.txt, bỏ qua..."
fi

step "6/8: Liên kết cấu hình Dotfiles (GNU Stow)"
if [ -d "$DOTFILES_DIR/stow" ]; then
    info "Đang áp dụng Symlink vào thư mục HOME..."
    cd "$DOTFILES_DIR/stow"
    for dir in */; do
        dir=${dir%/}
        stow -R -t "$HOME" "$dir"
        echo -e "  └─ Linked module: ${GREEN}$dir${NC}"
    done
    success "Đã khôi phục toàn bộ Dotfiles!"
else
    error "Không tìm thấy thư mục stow!"
fi

step "7/8: Kích hoạt System Services"
info "Bật NetworkManager & Bluetooth..."
sudo systemctl enable --now NetworkManager 2>/dev/null || true
sudo systemctl enable --now bluetooth 2>/dev/null || true
success "Services đã được kích hoạt!"

step "8/8: Cấu hình Shell mặc định"
if [ "$SHELL" != "$(which zsh)" ]; then
    info "Đang đổi Default Shell sang Zsh..."
    sudo chsh -s "$(which zsh)" "$USER"
    success "Đã chuyển shell sang Zsh!"
else
    success "Default Shell hiện tại đã là Zsh!"
fi

# --- HOÀN TẤT ---
echo -e "\n${GREEN}${BOLD}===============================================================${NC}"
echo -e "${GREEN}${BOLD}   🎉 QUÁ TRÌNH KHÔI PHỤC HYPRCTALIA HOÀN TẤT THÀNH CÔNG!     ${NC}"
echo -e "${GREEN}${BOLD}===============================================================${NC}"
echo -e "  ${YELLOW}👉 Khởi động lại hệ thống:${NC}  gõ ${CYAN}reboot${NC}"
echo -e "  ${YELLOW}👉 Hoặc vào thẳng Hyprland:${NC} gõ ${CYAN}Hyprland${NC}\n"