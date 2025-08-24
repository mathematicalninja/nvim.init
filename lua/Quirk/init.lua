print("hiya Quirk")

-- print(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("Quirk.settings")
require("Quirk.keymaps")
require("Quirk.autocommands")
require("Quirk.lazy_init")

require("Quirk.lsp")
require("Quirk.commands")
