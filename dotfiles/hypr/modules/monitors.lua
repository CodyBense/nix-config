if Hostname == "revan" then
    hl.monitor({
        output = "eDP-1",
        position = "0x0",
        mode = "1920x1200@59.950",
        scale = "1",
    })

    hl.monitor({
        output = "DP-3",
        position = "1920x0",
        mode = "2560x1440@60",
        scale = "1",
    })
else
    hl.monitor({
        output = "DP-3",
        position = "1920x0",
        mode = "2560x1440@60",
        scale = "1",
    })
end
