print("Quirk.lazy_init -- here be lazy's ui cusomisation.")
-- [[ install `lazy.nvim` plugin manager ]]
--    see `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- checking if lazyvim is installed in stdpath, otherwise clone from git.
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    -- local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        error("error cloning lazy.nvim:\n" .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath) -- Adds (local) lazypath to the RunTime Path for nvim

require("lazy").setup({
    -- loads my plugins from "~/.config/nvim/lua/Quirk/lazy/"
    spec = "Quirk.lazy",
    change_detection = { notify = false },
    {
        install = {
            -- install missing plugins on startup. This doesn't increase startup time.
            missing = true,
            -- try to load one of these colorschemes when starting an installation during startup
            colorscheme = { "catppuccin-mocha" },
        },
        ui = {
            -- a number <1 is a percentage., >1 is a fixed size
            size = { width = 0.8, height = 0.8 },
            wrap = true, -- wrap the lines in the ui
            -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
            -- - "bold": Bold line box.
            -- - "double": Double-line box.
            -- - "none": No border.
            -- - "rounded": Like "single", but with rounded corners ("╭" etc.).
            -- - "shadow": Drop shadow effect, by blending with the background.
            -- - "single": Single-line box.
            -- - "solid": Adds padding by a single whitespace cell.

            border = "shadow",
            -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
            backdrop = 40,
            title = nil, ---@type string only works when border is not "none"
            title_pos = "center", ---@type "center" | "left" | "right"
            -- Show pills on top of the Lazy window
            pills = true, ---@type boolean
            icons = {
                -- inserting unicode:
                -- 1. insert mode
                -- 2. <C-v>
                -- 3. U/u for 8/4 hex characters
                -- 4. type unicode hex
                -- cmd = "⌘",
                cmd = " ",
                -- config = "🛠",
                config = "",
                debug = "● ",
                -- event = "📅",
                event = " ",
                favorite = "💜",
                -- ft = "📂",
                ft = " ",
                init = "⚙ ",
                -- init = " ",
                import = " ",
                -- keys = "🗝",
                keys = " ",
                -- lazy = "󰒲 ",
                lazy = "⏼ ",
                loaded = "● ",
                not_loaded = "○ ",
                -- plugin = "🔌",
                plugin = " ",
                -- runtime = "💻",
                runtime = " ",
                -- require = "🌙",
                require = "󰢱 ",
                -- source = "📄",
                source = " ",
                -- start = "🚀",
                start = "⏻ ",
                -- task = "📌",
                task = "✔ ",
                list = {
                    "●",
                    "➜",
                    "★",
                    "‒",
                },
            },
        },
    },
})
