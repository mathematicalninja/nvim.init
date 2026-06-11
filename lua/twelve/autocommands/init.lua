-- print("Quirk.autocommands")
-- [[ Basic Autocommands ]]
--
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Flash highlight when yanking text",
    group = vim.api.nvim_create_augroup("YankGroup", {
        clear = true,
    }),
    callback = function()
        vim.hl.on_yank()
    end,
})
