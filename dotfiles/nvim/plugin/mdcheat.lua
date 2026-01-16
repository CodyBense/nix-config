local state = {
    open = {
        buf = -1,
        win = -1,
    }
}

local function create_new_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.4)

    local col = math.floor((vim.o.columns - width) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        width = width,
        style = "minimal",
        split = "left",
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local toggle_mdcheat = function ()
    if not vim.api.nvim_win_is_valid(state.open.win) then
        state.open = create_new_window { buf = state.open.buf }
        if vim.bo[state.open.buf].buftype ~= "mdcheat" then
            vim.cmd('edit ~/.config/nvim/plugin/md_cheat_sheet')
        end
    else
        vim.api.nvim_win_hide(state.open.win)
    end
end

vim.api.nvim_create_user_command("Mdcheat", toggle_mdcheat, {})
vim.keymap.set("n", "<space>md", toggle_mdcheat)
