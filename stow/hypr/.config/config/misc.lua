hl.config({
    dwindle = {
        preserve_split = true,
    },
    misc = {
        col = {
            splash = CACHYLGREEN,
        },
        middle_click_paste = false,
        enable_swallow = true,
        swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
        vrr = 0, -- Tắt VRR/Adaptive-Sync để tránh xung đột tần số quét giữa 2 màn hình
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
    cursor = {
        no_hardware_cursors = true, -- Fix khựng/lag con trỏ chuột trên NVIDIA Wayland
    },
    xwayland = {
        force_zero_scaling = true,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})
