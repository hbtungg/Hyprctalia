-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly

-- MONITOR1 (eDP-1: Màn laptop) đặt ở bên PHẢI (X = 1920)
hl.monitor({
    output    = MONITOR1,
    mode      = "1920x1080@144.00",
    position  = "1920x0",
    scale     = "1.2",
})

-- MONITOR2 (HDMI-A-1: Màn phụ rời) đặt ở bên TRÁI (X = 0)
hl.monitor({
    output    = MONITOR2,
    mode      = "1920x1080@144.00",
    position  = "0x0",
    scale     = "1",
})
