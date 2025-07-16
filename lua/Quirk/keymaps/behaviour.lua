-- void pasting
vim.keymap.set("x", "<leader>p", [["_dP]])
-- void delete
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- sets mark a (ma) formats (=) around paragraph (ap) moves back to mark a ('a) rather than leaving cursor at top of paragraph.
vim.keymap.set("n", "=ap", "ma=ap'a")

-- project view
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- for fun
-- vim.keymap.set("n", "<leader>ca", function()
-- 	require("cellular-automaton").start_animation("make_it_rain")
-- end)
