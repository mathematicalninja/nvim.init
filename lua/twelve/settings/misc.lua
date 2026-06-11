vim.opt.cursorcolumn = true
-- the number of columns for line numbers, expands as needed.
vim.opt.nuw = 1

-- turn on spelling
vim.opt.spell = true
-- statuscolumn	custom format for the status column
-- (local to window)
-- set stc=
-- statusline	alternate format to be used for a status line
-- clipboard	"unnamed" to use the * register like unnamed register
-- "autoselect" to always put selected text on the clipboard
-- set cb=unnamedplus
-- <Tab> ==> spaces in insert mode.
--vim.opt.clipboard = "unnamedplus"

vim.opt.expandtab = true

vim.o.digraph = false
-- pcall(vim.keymap.del, "i", "<C-k>") -- overkill just in case
vim.keymap.set( --
    "i",
    "<M-C-S-D-Space>",
    function()
        -- SOME function that calls digraphs
    end
)
