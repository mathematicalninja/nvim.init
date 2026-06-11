vim.pack.add({
    gh("echasnovski/mini.nvim"),
})
require("mini.ai").setup({
    n_lines = 500,

    -- custom_textobjects = {
    --     w = require("mini.ai").gen_spec.treesitter({ a = "@word.outer", i = "@word.inner" }),
    -- },
})
require("mini.surround").setup()
local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
statusline.section_location = function()
    return "%2l:%-2v"
end
