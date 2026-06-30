local appList = {
    "udiskie",
    "noctalia",
}

-- local localAppList
-- if Hostname == "revan" then
-- 	-- If on desktop do desktop things
-- 	localAppList = {
-- 		"wayvnc 0.0.0.0 --output=DP-1",
-- 		"quickshell",
-- 	}
-- elseif Hostname == "maul" then
-- 	-- If on laptop, do laptop things
-- 	localAppList = {
-- 		"way-edges",
-- 		"waybar",
-- 		"dunst",
-- 	}
-- end

-- for _, command in ipairs(localAppList) do
-- 	table.insert(appList, command)
-- end

-- For everything in the applist run it on startup
hl.on("hyprland.start", function()
    for _, command in ipairs(appList) do
        hl.exec_cmd(command)
    end
end)
