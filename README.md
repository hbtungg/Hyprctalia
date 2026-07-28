<div align="center">

# 🌙 Hyprctalia

**Dotfiles cá nhân cho Arch Linux + Hyprland + Noctalia**

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-58E1FF?style=for-the-badge&logo=wayland&logoColor=black)](https://hyprland.org/)
[![Kitty](https://img.shields.io/badge/Kitty-0D1117?style=for-the-badge&logo=gnu-bash&logoColor=orange)](https://sw.kovidgoyal.net/kitty/)
[![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.zsh.org/)

![GitHub last commit](https://img.shields.io/github/last-commit/hbtungg/Hyprctalia?style=flat-square&color=blueviolet)
![GitHub repo size](https://img.shields.io/github/repo-size/hbtungg/Hyprctalia?style=flat-square&color=orange)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)

</div>

---

## 📖 Giới thiệu

**Hyprctalia** là bộ dotfiles cá nhân được cấu hình cho một hệ thống **Arch Linux** tối giản, mượt mà, sử dụng **Hyprland** làm Wayland Compositor kết hợp với **Noctalia Shell** cho thanh bar và widgets. Repo này được thiết kế để có thể **khôi phục lại toàn bộ môi trường làm việc chỉ với một dòng lệnh** ngay từ TTY sau khi cài đặt Arch Linux trắng.

---

## 🧩 Thành phần hệ thống

| Thành phần | Công cụ sử dụng |
|---|---|
| 🖥️ **Hệ điều hành** | Arch Linux |
| 🪟 **Window Manager** | [Hyprland](https://hyprland.org/) |
| 📊 **Shell / Bar / Widgets** | [Noctalia V5](https://github.com/noctalia-dev/noctalia-shell) (`noctalia-git` - AUR) |
| 💻 **Terminal** | [Kitty](https://sw.kovidgoyal.net/kitty/) |
| 🐚 **Shell** | Zsh + [Oh My Zsh](https://ohmyz.sh/) |
| 📦 **AUR Helper** | [Paru](https://github.com/Morganamilo/paru) |
| 🔗 **Dotfiles Manager** | [GNU Stow](https://www.gnu.org/software/stow/) |
| ⌨️ **Input Method** | [Fcitx5](https://fcitx-im.org/wiki/Fcitx5) (bảng gõ Lotus) |
| ⚙️ **Tự động hóa cài đặt** | `install.sh` |

---

## 🚀 Khôi phục 1-Click từ TTY (Cài lại Arch trắng)

Sau khi cài Arch Linux xong (base system), khởi động vào **TTY**, thực hiện theo các bước sau:

### 1️⃣ Kết nối Wi-Fi (bỏ qua nếu dùng dây LAN)

```bash
nmcli device wifi list
nmcli device wifi connect "TEN_WIFI" password "MAT_KHAU_WIFI"
```

Kiểm tra kết nối:

```bash
ping -c 3 archlinux.org
```

### 2️⃣ Cài Git (nếu chưa có)

```bash
sudo pacman -Sy git --noconfirm
```

### 3️⃣ Clone repo về `~/dotfiles`

```bash
git clone https://github.com/hbtungg/Hyprctalia.git ~/dotfiles
cd ~/dotfiles
```

### 4️⃣ Chạy script cài đặt tự động

```bash
chmod +x install.sh
./install.sh
```

> **`install.sh` sẽ tự động:**
> - ✅ Cài đặt **Paru** (AUR helper) nếu chưa có
> - ✅ Cài đặt **Oh My Zsh**
> - ✅ Cài toàn bộ package trong `pkglist-native.txt` (kho chính thức) và `pkglist-aur.txt` (AUR - qua Paru)
> - ✅ Chạy **GNU Stow** để symlink toàn bộ config từ thư mục `stow/` vào `$HOME`

### 5️⃣ Khởi động lại và đăng nhập vào Hyprland

```bash
reboot
```

Sau khi khởi động lại, chọn session **Hyprland** tại màn hình đăng nhập (hoặc gõ `Hyprland` nếu bạn login thẳng qua TTY).

---

## 📁 Cấu trúc thư mục

```
Hyprctalia/
├── install.sh                 # Script tự động cài đặt & khôi phục hệ thống
├── pkglist-native.txt         # Danh sách package từ kho chính thức Arch
├── pkglist-aur.txt            # Danh sách package từ AUR
├── stow/                      # Thư mục chứa toàn bộ config, quản lý bởi GNU Stow
│   ├── hypr/
│   │   └── .config/
│   │       └── hypr/
│   │           ├── hyprland.conf
│   │           └── ...
│   ├── noctalia/
│   │   └── .config/
│   │       └── noctalia/
│   │           └── ...
│   ├── kitty/
│   │   └── .config/
│   │       └── kitty/
│   │           └── kitty.conf
│   ├── zsh/
│   │   ├── .zshrc
│   │   └── .oh-my-zsh-custom/
│   └── fcitx5/
│       └── .config/
│           └── fcitx5/
│               └── ...
└── README.md
```

> 💡 Mỗi thư mục con trong `stow/` tương ứng với **một package Stow**. Khi chạy `stow <tên-package>`, Stow sẽ tạo symlink từ `stow/<tên-package>/` vào `$HOME`, giữ nguyên cấu trúc thư mục bên trong.

---

## 🔄 Đồng bộ & cập nhật dotfiles

### Cập nhật danh sách package đã cài

Sau khi cài thêm/gỡ package trên hệ thống, hãy cập nhật lại 2 file danh sách để lần khôi phục sau luôn đầy đủ:

```bash
# Package từ kho chính thức (native)
pacman -Qqen > ~/dotfiles/pkglist-native.txt

# Package từ AUR
pacman -Qqem > ~/dotfiles/pkglist-aur.txt
```

### Đẩy thay đổi config lên GitHub

```bash
cd ~/dotfiles
git add .
git commit -m "update: sync dotfiles $(date +%Y-%m-%d)"
git push origin main
```

### Kéo cập nhật mới nhất về (trên máy khác hoặc sau khi thay đổi từ xa)

```bash
cd ~/dotfiles
git pull origin main
stow -R */    # Restow lại toàn bộ package nếu có file mới
```

### Thêm một config mới vào Stow

```bash
mkdir -p ~/dotfiles/stow/<ten-app>/.config/<ten-app>
mv ~/.config/<ten-app>/* ~/dotfiles/stow/<ten-app>/.config/<ten-app>/
cd ~/dotfiles
stow <ten-app>
```

---

## ⚠️ Lưu ý

- Trước khi chạy `install.sh` trên máy đã có sẵn config, nên **backup** các file `.config` hiện tại để tránh xung đột symlink với Stow (`stow` sẽ báo lỗi nếu file gốc không phải symlink và đã tồn tại).
- Kiểm tra kỹ `pkglist-aur.txt` trước khi cài trên máy mới, vì một số package AUR có thể build lâu hoặc yêu cầu tương tác thủ công.

---

<div align="center">

Made with 🌙 by [hbtungg](https://github.com/hbtungg)

</div>
