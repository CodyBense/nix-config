-- Notification helper function
-- local function notif(text, timeout, icon)
--     hl.notification.create({
--         text = text or "notification",
--         timeout = timeout or 2000,
--         icon = icon or "ok",
--     })
-- end

local mainMod = "SUPER + "
local subMod = mainMod
local keybindIndex = 1

if Hostname == "maul" then
    mainMod = "SUPER + "
    subMod = mainMod
    keybindIndex = 2
end


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

local terminal = "kitty"
local browser = "hellium"
local fileManager = "dolphin"

-- can add a second key in the key table to have a different bind on another system
-- Key = { "Q", "BACKSPACE"}
local globalAppBinds = {
    ---- Window functions
    { key = { "Q" },          dispatch = hl.dsp.window.close() },
    { key = { "R" },          dispatch = hl.dsp.layout("colresize +conf") },
    { key = { "V" },          dispatch = hl.dsp.window.float() },
    { key = { "M", "" },      dispatch = switchMonitors() },

    ---- Special workspaces
    { key = { "S" },          dispatch = hl.dsp.workspace.toggle_special("magic") },


    ---- Apps
    -- Launcher
    { key = { "SPACE" },      dispatch = hl.dsp.exec_cmd("noctalia msg panel-toggle launcher") },
    { key = { "BACKSPACE" },  dispatch = hl.dsp.workspace.toggle_special("noctalia msg panel-toggle session") },
    { key = { "C" },          dispatch = hl.dsp.workspace.toggle_special("noctalia msg panel-toggle clipboard") },
    { key = { "PERIOD" },     dispatch = hl.dsp.workspace.toggle_special("noctalia msg panel-toggle launcher /emo") },
    { key = { "N" },          dispatch = hl.dsp.workspace.toggle_special("noctalia msg panel-toggle control-center notifications") },
    { key = { "SHIFT + N" },          dispatch = hl.dsp.exec_cmd("kitty --app-id notes-manager ~/.config/hypr/scripts/notes-manage.sh") },
    { key = { "SHIFT + P" },          dispatch = hl.dsp.exec_cmd("~/.config/hypr/scripts/project-launch.sh") },
    { key = { "CTRL + P" },          dispatch = hl.dsp.exec_cmd("kitty --app-id project-create project-create") },
    { key = { "ALT + S" },          dispatch = hl.dsp.exec_cmd("~/.config/hypr/scripts/ssh-connections.sh") },

    -- Terminal
    { key = { "T" },          dispatch = hl.dsp.exec_cmd(terminal) },

    -- Browser
    { key = { "F" },          dispatch = hl.dsp.exec_cmd(browser) },

    -- File browser
    { key = { "SHIFT + E" },          dispatch = hl.dsp.exec_cmd("~/nix-config/dotfiles/niri/scripts/launch-file-manager.sh") },
    { key = { "ALT + E" },          dispatch = hl.dsp.exec_cmd(fileManager) },

    --- Move Window
    { key = { "H" },          dispatch = hl.dsp.focus({direction = "left"}) },
    { key = { "L" },          dispatch = hl.dsp.focus({direction = "right"}) },
    { key = { "K" },          dispatch = hl.dsp.focus({direction = "up"}) },
    { key = { "J" },          dispatch = hl.dsp.focus({direction = "down"}) },
    { key = { "SHIFT + H" },          dispatch = hl.dsp.layout({direction = "swapcol l"}) },
    { key = { "SHIFT + L" },          dispatch = hl.dsp.layout({direction = "swapcol r"}) },

    -- Mouse
    { key = { "mouse_down" },          dispatch = hl.dsp.focus({workspace = "e+1"}) },
    { key = { "mouse_up" },          dispatch = hl.dsp.focus({workspace = "e-1"}) },
    { key = { "mouse:272" },          dispatch = hl.dsp.window.drag(), opts = { mouse = true} },
    { key = { "mouse:273" },          dispatch = hl.dsp.window.resize(), opts = {mouse = true} },


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

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " SHIFT +  " .. key, hl.dsp.window.move({ workspace = i }))
end
