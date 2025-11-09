-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Avoids repeating refisters by mistake.
vim.keymap.set("n", "Q", "<nop>")

-- insert mode accidental duplicate escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Stupid Korean keyboards missing vital keys.
vim.keymap.set({ "i", "t", "c" }, "<C-/>", "\\")
vim.keymap.set({ "i", "t", "c" }, "<C-S-/>", "|")

-- Use command line more often than jump to previous.
vim.keymap.set({ "n" }, ";", ":")
vim.keymap.set({ "n" }, ":", ";")
