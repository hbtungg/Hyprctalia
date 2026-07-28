-- Workspace rules wiki https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Màn 1 (Laptop): Khởi chạy mặc định ở Workspace 1
hl.workspace_rule({ workspace = "1", monitor = MONITOR1, default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = MONITOR1, persistent = true })
hl.workspace_rule({ workspace = "3", monitor = MONITOR1, persistent = true })

-- Màn 2 (HDMI): Khởi chạy mặc định ở Workspace 4
hl.workspace_rule({ workspace = "4", monitor = MONITOR2, default = true, persistent = true })
hl.workspace_rule({ workspace = "5", monitor = MONITOR2, persistent = true })
hl.workspace_rule({ workspace = "6", monitor = MONITOR2, persistent = true })

-- Workspace riêng cho Gaming (Auto gán sang Màn chính Laptop hoặc HDMI tùy anh chọn)
hl.workspace_rule({ workspace = "name:gaming", monitor = MONITOR1 })
