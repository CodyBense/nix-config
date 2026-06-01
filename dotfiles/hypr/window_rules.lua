--------------------
---- WORKSPACES ----
--------------------

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name = "kitty",
    match = {
        class = "^kitty$" ,
    },
    workspace =  "1",
})

hl.window_rule({
    name = "emacs",
    match = {
        class = "^emacs$" ,
    },
    workspace =  "1",
})

hl.window_rule({
    name = "browser",
    match = {
        class = "^helium$",
    },
    workspace = "2",
})

hl.window_rule({
    name = "dolphin",
    match = {
        class = "org.kde.dolphin",
        },
    workspace = "3",
})

hl.window_rule({
    name = "yazi",
    match = {
        class = "files",
    },
    workspace = "3",
})

hl.window_rule({
    name = "project-launch",
    match = {
        class = "project-launch",
    },
    float = true,
    size = {"(monitor_w*0.5)", "(monitor_h*0.5)"},
})

hl.window_rule({
    name = "project-create",
    match = {
        class = "project-create",
    },
    float = true,
    size = {"(monitor_w*0.5)", "(monitor_h*0.5)"},
})

hl.window_rule({
    name = "ssh-connections",
    match = {
        class = "ssh-connections",
    },
    float = true,
    size = {"(monitor_w*0.5)", "(monitor_h*0.5)"},
})

hl.window_rule({
    name = "notes-manager",
    match = {
        class = "notes-manager",
    },
    float = true,
    size = {"(monitor_w*0.5)", "(monitor_h*0.5)"},
})
