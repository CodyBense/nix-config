hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- Define windows that go to a particular workspace
local workspace1Windows = {
    { class = "kitty",   workspace = "1" },
    { class = "emacs",   workspace = "1" },
    { class = "helium",  workspace = "2" },
    { class = "dolphin", workspace = "3" },
    { class = "files",   workspace = "3" },
    { class = "Spotify", workspace = "special:magic" },
    { class = "vesktop", workspace = "special:discord" },
}

for _, window in ipairs(workspace1Windows) do
    hl.window_rule({
        name = ("workspace " .. window.workspace .. " : " .. window.class),
        match = {
            class = ("^" .. (window.class or "") .. "$"),
        },
        workspace = window.workspace,
    })
end

-- Define windows that float
local floatingWindows = {
    { class = "project-launch" },
    { class = "project-create" },
    { class = "ssh-connections" },
    { class = "notes-manager" },
}

for _, window in ipairs(floatingWindows) do
    hl.window_rule({
        name = ("floating " .. window.class),
        match = {
            class = ("^" .. (window.class or "") .. "$"),
        },
        float = true,
        size = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
    })
end
