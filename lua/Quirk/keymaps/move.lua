-- Remapped arrows for faster navigation.
vim.keymap.set("n", "<left>", "b", { desc = "move Left by word" })
vim.keymap.set("n", "<right>", "w", { desc = "move Right by word" })
vim.keymap.set("n", "<up>", "k_", { desc = "move Up to start of code line" })
vim.keymap.set("n", "<down>", "j_", { desc = "move Down to start of code line" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "< s-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- TODO: correct "set mark" --> visual select line, process.
-- vim.keymap.set("n", "<C-J>", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("n", "<C-K>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- merge this line, and keep cursor in nice place
vim.keymap.set("n", "J", "mzJ`z")
-- half page jumps, with centering.
vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc = "[d]own half page, centered."} )
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc = "[u]p half page, centered."} )
-- next (n)/ previous (N) serach result, center the line (zz) and show line if folded (zv)
vim.keymap.set("n", "n", "nzzzv", {desc = "[n]ext result, centered, unfolded."} )
vim.keymap.set("n", "N", "Nzzzv", {desc = "¬[N]ext result, centered, unfolded."} )
