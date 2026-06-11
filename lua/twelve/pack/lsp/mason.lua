vim.pack.add({
    gh("mason-org/mason.nvim"),
    gh("mason-org/mason-lspconfig.nvim"),
    gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
})

local mason = require("mason")
mason.setup({})
local mason_lsp = require("mason-lspconfig")
local mason_installer = require("mason-tool-installer")

local M = {
    mason = mason,
    mason_lsp = mason_lsp,
    mason_installer = mason_installer,
}

return M
