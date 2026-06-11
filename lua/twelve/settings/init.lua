-- print("twelve.settings")

require("twelve.settings.leader")
require("twelve.settings.mouse")
require("twelve.settings.sidebar")
require("twelve.settings.visual")
require("twelve.settings.saving")
require("twelve.settings.statusBar")
require("twelve.settings.searching")
--require("twelve.settings.move")
require("twelve.settings.misc")
require("twelve.settings.folding")

-- NOTE: vim.o.[---] and vim.opt.[---] are largely similar, the latter (opt) allowing tables for setting values, and single value settings being shared between both.

-- NOTE: the below are the "miscellanious" settings that I havn't grouped or don't think I'll be editing as a group.

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--[[
    NOTE: xclip or similar may need to be installed.
--]]
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- Increased mapped sequence wait time
vim.o.timeoutlen = 1000

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true
