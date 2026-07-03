-- Get window position relative to monitor
local function normalise_current_window_pos()
    local active = hl.get_active_window()
    if active then
        local xpos = active.at.x
        -- If on right monitor
        if xpos > 1920 then
            xpos = xpos - 1920
            return xpos
            -- If on left monitor
        elseif xpos < 1 then
            xpos = xpos + 1920
            return xpos
        else
            return xpos
        end
    end
end

-- Notification helper function
local function notif(text, timeout, icon)
    hl.notification.create({
        text = text or "notification",
        timeout = timeout or 2000,
        icon = icon or "ok",
    })
end

-- Monitor switching function
local function switchMonitors()
    local LAPTOP = "eDP-1"
    local EXTERNAL = "DP-3"

    local LAPTOP_SPEC = {
        output   = "eDP-1",
        mode     = "1920x1200@59.950",
        position = "0x0",
        scale    = "1",
        disabled = false,
    }

    local EXTERNAL_SPEC = {
        output = "DP-3",
        mode = "2560x1440@60",
        position = "1920x0",
        scale = "1",
        disabled = false,
    }

    local laptopOn = hl.get_monitor(LAPTOP) ~= nil
    local externalOn = hl.get_monitor(EXTERNAL) ~= nil

    local target, targetSpec, disable

    if laptopOn and externalOn then
        target = EXTERNAL
        targetSpec = EXTERNAL_SPEC
        disable = LAPTOP
    elseif externalOn then
        target = LAPTOP
        targetSpec = LAPTOP_SPEC
        disable = EXTERNAL
    elseif laptopOn then
        target = EXTERNAL
        targetSpec = EXTERNAL_SPEC
        disable = LAPTOP
    else
        target = LAPTOP
        targetSpec = LAPTOP_SPEC
        disable = EXTERNAL
    end

    hl.monitor({ output = disable, disabled = true })
    os.execute("sleep 0.5")

    hl.monitor(targetSpec)
    os.execute("sleep 0.5")
end

-- Set modifier keys
local mainMod = "SUPER + "
local subMod = mainMod
local keyboardString = "1234567890"
local keybindIndex = 1
local recordingMode = 0

-- Set different modifiers on laptop
if Hostname == "maul" then
    mainMod = "SUPER + "
    subMod = mainMod
    keyboardString = "1234567890"
    keybindIndex = 2
end

local globalAppBinds = {

    ---- Window functions
    { key = { "Q" },         dispatch = hl.dsp.window.close() },
    { key = { "R" },         dispatch = hl.dsp.layout("colresize +conf") },
    { key = { "V" },         dispatch = hl.dsp.window.float() },
    { key = { "M", "" },     dispatch = function() switchMonitors() end },

    ---- Apps
    -- Launcher
    { key = { "SPACE" },     dispatch = "noctalia msg panel-toggle launcher" },
    { key = { "BACKSPACE" }, dispatch = "noctalia msg panel-toggle session" },
    { key = { "C" },         dispatch = "noctalia msg panel-toggle clipboard" },
    { key = { "PERIOD" },    dispatch = "noctalia msg panel-toggle launcher /emo" },
    { key = { "N" },         dispatch = "noctalia msg panel-toggle control-center notifications" },
    { key = { "SHIFT + N" }, dispatch = "kitty --app-id notes-manager ~/.config/hypr/scripts/notes-manager.sh" },
    { key = { "SHIFT + P" }, dispatch = "~/.config/hypr/scripts/project-launch.sh" },
    { key = { "CTRL + P" },  dispatch = "kitty --app-id project-create project-create" },
    { key = { "ALT + S" },   dispatch = "~/.config/hypr/scripts/ssh-connections.sh" },

    -- emacs
    { key = { "E" },         dispatch = "emacs" },

    -- Terminal
    { key = { "T" },         dispatch = "kitty" },

    -- Helium and file browser
    { key = { "F" },         dispatch = "helium" },
    { key = { "Y" },         dispatch = "~/nix-config/dotfiles/niri/scripts/launch-file-manager.sh" },
    { key = { "ALT + E" },   dispatch = "dolphin" },


    ---- Move windows
    { key = { "H" },         dispatch = hl.dsp.focus({ direction = "left" }) },
    { key = { "L" },         dispatch = hl.dsp.focus({ direction = "right" }) },
    { key = { "SHIFT + H" }, dispatch = hl.dsp.layout("swapcol l") },
    { key = { "SHIFT + L" }, dispatch = hl.dsp.layout("swapcol r") },
    {
        key = { "CTRL + S" },
        dispatch = function()
            hl.dispatch(hl.dsp.layout("colresize +conf"))
            hl.dispatch(hl.dsp.focus({ direction = "l" }))
            hl.dispatch(hl.dsp.layout("colresize +conf"))
            hl.dispatch(hl.dsp.focus({ direction = "r" }))
        end
    },

    ---- Special Workspaces
    { key = { "S" },          dispatch = hl.dsp.workspace.toggle_special("magic") },
    { key = { "SHIFT + S" },  dispatch = hl.dsp.window.move({ workspace = "special:magic", follow = false }) },
    { key = { "D" },          dispatch = hl.dsp.workspace.toggle_special("discord") },
    { key = { "SHIFT + D" },  dispatch = hl.dsp.window.move({ workspace = "special:discord", follow = false }) },

    -- Mouse
    { key = { "mouse_down" }, dispatch = hl.dsp.focus({ workspace = "e+1" }) },
    { key = { "mouse_up" },   dispatch = hl.dsp.focus({ workspace = "e-1" }) },
    { key = { "mouse:272" },  dispatch = hl.dsp.window.drag(),                                                 opts = { mouse = true } },
    { key = { "mouse:273" },  dispatch = hl.dsp.window.resize(),                                               opts = { mouse = true } },


    -- Laptop buttons
    {
        key = { "XF86AudioRaiseVolume" },
        dispatch = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+",
        opts = { locked = true, repeating = true }
    },
    {
        key = { "XF86AudioLowerVolume" },
        dispatch = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
        opts = { locked = true, repeating = true }
    },
    { key = { "XF86AudioMute" },         dispatch = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", opts = { locked = true, repeating = true } },
    {
        key = { "XF86AudioMicMute" },
        dispatch = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
        opts = { locked = true, repeating = true }
    },
    { key = { "XF86MonBrightnessUp" },   dispatch = "brightnessctl set +5%",                      opts = { locked = true, repeating = true } },
    { key = { "XF86MonBrightnessDown" }, dispatch = "brightnessctl set 5%-",                      opts = { locked = true, repeating = true } },
    { key = { "XF86AudioNext" },         dispatch = "playerctl next",                             opts = { locked = true } },
    { key = { "XF86AudioPause" },        dispatch = "playerctl play-pause",                       opts = { locked = true } },
    { key = { "XF86AudioPlay" },         dispatch = "playerctl play-pause",                       opts = { locked = true } },
    { key = { "XF86AudioPrev" },         dispatch = "playerctl previous",                         opts = { locked = true } },

}

-- Workspace switch keys
for _, bind in ipairs(globalAppBinds) do
    local modBind = bind.mod or mainMod
    local command
    if type(bind.dispatch) ~= "string" then
        command = bind.dispatch
    else
        command = hl.dsp.exec_cmd(bind.dispatch)
    end
    local opts = {}
    if bind.opts then
        opts = bind.opts
    end
    if bind.key[keybindIndex] then
        hl.bind(modBind .. bind.key[keybindIndex], command, opts)
    else
        hl.bind(modBind .. bind.key[1], command)
    end
end

-- Workspace functions
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
