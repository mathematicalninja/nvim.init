-- print("Quirk.keymaps")
require("Quirk.keymaps.basic")
require("Quirk.keymaps.move")
require("Quirk.keymaps.behaviour")

-- Bug: want this to integrate properly.
-- vim.keymap.set("x", "<C-Enter>","<nop>", {desc = "No Operation on Crtl Enter, to allow cmp to take over."

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TODO: specifics for how to do vim.cmd.write in insert mode.
-- vim.keymap.set("i", "<C-s>", vim.cmd.w)

-- TODO: save all in normal mode
-- vim.keymap.set("n", "<C-s>", vim.cmd.wa)

-- Terminal zoom for Ubuntu
-- vim.keymap.set("n", "<C-+>", "<C-S-+>")
-- FIXME:
-- vim.keymap.set("n", "+", "<C-=>")
