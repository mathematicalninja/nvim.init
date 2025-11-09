-- void pasting
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("v", "p", [["_dP]])
-- void delete
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<leader>D", '"_D')
-- void change
vim.keymap.set({ "n", "v" }, "<leader>c", '"_c')
vim.keymap.set({ "n", "v" }, "<leader>C", '"_C')

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- sets mark a (ma) formats (=) around paragraph (ap) moves back to mark a ('a) rather than leaving cursor at top of paragraph.
vim.keymap.set("n", "=ap", "ma=ap'a")

-- project view ==> Oil handles this now
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- for fun
-- vim.keymap.set("n", "<leader>ca", function()
-- 	require("cellular-automaton").start_animation("make_it_rain")
-- end)

-- insert mode save.
vim.keymap.set({ "n", "i" }, "<C-s>", "<CMD>w<CR>")

-- lua sorcing to avoid accidental `:sp`
vim.keymap.set("n", "<leader><leader>s", "<CMD>so<CR>", { desc = "lua [s]orcing to avoid accidental `:sp`" })

--
-- TODO: add in "z=" for spell suggestions when available? or make it the default, then on LSP attach add this, and a "in comments ==> z= check"
vim.keymap.set("n", "<leader>k", function()
    vim.diagnostic.open_float()
end, { desc = "look up[k] at diagnostics" })

--TODO: pipe spellfix somewhere else.
vim.keymap.set("n", "<leader>j", "z=", { desc = "correct word under[j] cursor" })

-- fed up of "s" in the middle of a messed up key combination deleting things.
-- And I don't need an abbreviation for a 2 letter code.
vim.keymap.set("n", "s", "<nop>", { desc = "remove cl alias" })
vim.keymap.set("n", "S", "<nop>", { desc = "remove cc alias" })

vim.keymap.set( --
    "n",
    "<leader><leader>z",
    "v%:fold<CR>",
    { desc = "create a matching pair fold, and close it." }
)
