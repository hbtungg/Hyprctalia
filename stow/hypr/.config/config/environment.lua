-- Environmental variables (https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/)
-- if you use UWSM, define your variables in ~/.config/uwsm/env
-- if you don't use UWSM, define your variables here (e.g. hl.env("QT_QPA_PLATFORM", "wayland"))

--------------------------------------------------------------------------------
-- 1. GPU / AQUAMARINE CONFIG (SỬA ĐỂ TẮT NVIDIA KHI DÙNG THƯỜNG)
--------------------------------------------------------------------------------
-- Ép iGPU AMD Radeon Vega làm Render chính cho Compositor/Desktop.
-- NVIDIA xếp sau, chỉ chạy khi có app/game yêu cầu (D3cold Dynamic Power Management).
-- GIẢ ĐỊNH: card1 là AMD, card2 là NVIDIA (Sử dụng 'ls -l /dev/dri/by-path' để check lại)
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card2")

--------------------------------------------------------------------------------
-- 2. HARDWARE ACCELERATION & DRIVERS
--------------------------------------------------------------------------------
-- Bỏ ép global NVIDIA backend cho GBM/LIBVA để apps thường (Firefox/Discord) chạy trên AMD iGPU
-- Chỉ giữ lại biến cần thiết cho Wayland
hl.env("__GL_GSYNC_ALLOWED", "0")
hl.env("__GL_VRR_ALLOWED", "0")

--------------------------------------------------------------------------------
-- 3. TOOLKIT WAYLAND FORCING
--------------------------------------------------------------------------------
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

--------------------------------------------------------------------------------
-- 4. CURSOR & DISPLAY FIXES
--------------------------------------------------------------------------------
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
