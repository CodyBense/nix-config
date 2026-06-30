if Hostname == "revan" then
    hl.monitor({
        output   = "eDP-1",
        mode     = "1920x1200@59.950",
        position = "0x0",
        scale    = "1",
    })
end

hl.monitor({
    output = "DP-3",
    mode = "2560x1440@60",
    position = "1920x0",
    scale = "1",
    transform = 2,
})
