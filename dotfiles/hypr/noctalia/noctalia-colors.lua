local primary = "#cba6f7"
local surface = "#1e1e2e"
local secondary = "#fab387"
local error = "#f38ba8"
local tertiary = "#94e2d5"
local surface_lowest = "#212232"

hl.config({
    general = {
        col = {
            active_border = primary,
            inactive_border = surface,
        }
    },

    group = {
        col = {
            border_active = secondary,
            border_inactive = surface,
            border_locked_active = error,
            border_locked_inactive = surface,
        },

        groupbar = {
            col = {
                active = secondary,
                inactive = surface,
                locked_active = error,
                locked_inactive = surface,
            }
        }
    },

})
