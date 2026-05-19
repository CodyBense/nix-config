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
    name = "workspace-one",
    match = {
        class = "^kitty$" ,
        class = "^emacs$",
    },
    workspace =  "1",
})

hl.window_rule({
    name = "workspace-two",
    match = {
        class = "^helium$",
    },
    workspace = "2",
})

hl.window_rule({
    name = "workspace-three",
    match = {
        class = "^dolphin$",
        class = "^files$",
        },
    workspace = "3",
})

hl.window_rule({
    name = "floating",
    match = {
        class = "project-launch",
        class = "project-create",
        class = "ssh-connections",
    },
    float = true,
    size = {"(monitor_w*0.5)", "(monitor_h*0.5)"},
})
