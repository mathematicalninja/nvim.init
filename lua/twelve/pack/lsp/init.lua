-- TODO: create a "fold" for languages, pass in the __loaded__ versions of telescope, lsp, conform, etc. and allow each language.lua file to handle it's integrations at the language level.

vim.pack.add({
    gh("saghen/blink.lib"),
    gh("saghen/blink.cmp"),
    gh("folke/trouble.nvim"),
    gh("folke/lazydev.nvim"),
    gh("j-hui/fidget.nvim"),

    gh("hrsh7th/cmp-nvim-lsp"),
    gh("hrsh7th/cmp-buffer"),
    gh("hrsh7th/cmp-path"),
    gh("hrsh7th/cmp-cmdline"),
    gh("hrsh7th/nvim-cmp"),

    gh("nvim-lua/plenary.nvim"),
    gh("folke/todo-comments.nvim"),

    gh("neovim/nvim-lspconfig"),
})

local conform = require("twelve.pack.lsp.conform")
local mason = require("twelve.pack.lsp.mason")
local telescope = require("twelve.pack.lsp.telescope")
local utils = require("twelve.pack.lsp.utils")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

local add_server = function(server)
    -- For each LSP server (cfg), we merge:
    -- 1. A fresh empty table (to avoid mutating capabilities globally)
    -- 2. Your capabilities object with Neovim + cmp features
    -- 3. Any server-specific cfg.capabilities if defined in `servers`
    cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})

    vim.lsp.config(server, cfg)
    vim.lsp.enable(server)
end

---@alias server_opts {
---     filetypes,
---     formatter,
---     prepend_args,
---     append_args,
---}
---@param opts server_opts
local add_formatter_by_filetypes = function(opts)
    --
end

---@alias lang_tool string

local language_tools = {
    conform = conform,
    mason = mason,
    telescope = telescope,
    utils = utils,

    add_server = add_server,
    add_formatter_by_ft = add_formatter_by_filetypes,
}
require("twelve.pack.lsp.languages.init")(language_tools)
