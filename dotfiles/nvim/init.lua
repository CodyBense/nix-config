-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.undofile = true
vim.g.mapleader = " "

-- Keymaps
local map = vim.keymap.set
-- allows moving of selected lines and autoindent
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- add next line at end and keeps cursor in current position
map("n", "J", "mzJ`z")
-- half page jumps and keeys cursor in middle
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
-- keeps cursor in place when searching terms
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
-- copys over and puts replace in void register
map("x", "<leader>p", "\"_dP")
-- copys to computer clipboard
map({ "n", "v" }, "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")
-- deletes to void register
map("n", "<leader>d", "\"_d")
map("v", "<leader>d", "\"_d")
-- Q is a bad place?
map("n", "Q", "<nop>")
-- Source file
map("n", "<leader><leader>x", "<cmd>source %<CR>")
-- lsp format
map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<leader>gd", vim.lsp.buf.definition)
map("n", "<leader>gD", vim.lsp.buf.declaration)
-- Oil
map("n", "<leader>pv", "<CMD>Oil<CR>")
-- Mini.pick
map("n", "<leader>f", ":Pick files<CR>")
map("n", "<leader>s", ":Pick grep_live<CR>")
map("n", "<leader>gf", ":Pick files tool='git'<CR>")
map("n", "<leader>gs", ":Pick grep_live tool='git'<CR>")
map("n", "<leader>h", ":Pick help<CR>")
-- Undotree
map("n", "<leader>u", function()
    vim.cmd.UndotreeToggle()
    vim.cmd.UndotreeFocus()
end)
-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>")
-- Harpoon
map("n", "<C-e>", function()
    local harpoon = require("harpoon")
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)
map("n", "<leader>a", function() require("harpoon"):list():add() end)
map("n", "<C-j>", function() require("harpoon"):list():select(1) end)
map("n", "<C-k>", function() require("harpoon"):list():select(2) end)
map("n", "<C-l>", function() require("harpoon"):list():select(3) end)
map("n", "<C-;>", function() require("harpoon"):list():select(4) end)
map("n", "<leader>mr", function() require("harpoon"):list():remove() end)

-- Run :=vim.pack.del({'plugin'}) to remove plugin
vim.pack.add({
    { src = 'https://github.com/catppuccin/nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/mbbill/undotree' },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        version = 'master'
    },
    { src = 'https://github.com/tree-sitter-grammars/tree-sitter-markdown' },
    { src = 'https://github.com/folke/trouble.nvim' },
    {
        src = 'https://github.com/ThePrimeagen/harpoon',
        version = 'harpoon2'
    },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/rafamadriz/friendly-snippets' },
    { src = 'https://github.com/NvChad/nvim-colorizer.lua' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
})

-- Plygin settings
vim.cmd("colorscheme catppuccin-mocha")
require "oil".setup()
require "mini.pick".setup()
require "trouble".setup()
require "mini.icons".setup()
require "harpoon".setup()
require "mini.completion".setup()
require "mini.snippets".setup()
require "colorizer".setup()
require "mason".setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require "mason-lspconfig".setup({
    ensure_installed = {
        "arduino_language_server",
        "clangd",
        "bashls",
        "gopls",
        "lua_ls",
        "pylsp",
        "rust_analyzer",
    },
})
require "render-markdown".setup({
    enabled = true,
    render_modes = { 'n', 'c', 't' },
    file_types = { 'markdown' },
    nested = true,
    restart_highlighter = true,
})
require "nvim-treesitter.configs".setup({
    modules = {
    },
    ensure_installed = {
        "json",
        "lua",
        "python",
        "c",
        "vimdoc",
        "vim",
        "rust",
        "go",
        "markdown",
        "markdown_inline",
    },
    sync_install = true,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
    },
})
vim.lsp.enable(
    {
        "lua_ls",
        "pylsp",
        "bashls",
        "beautysh",
        "cbfmt",
        "gopls",
        "rust_analyzer",
        "yaml_language_server",
        "arduino_language_server",
        "clangd",
    }
)
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
})
vim.lsp.config("arduino_language_server", {
    cmd = {
        'arduino-language-server',
        '-cli-config',
        '$HOME/.arduino15/arduino-cli.yaml',
    },
})
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})
vim.cmd [[set completeopt+=menuone,noselect,popup]]
