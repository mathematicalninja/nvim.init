return { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote

        --d Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']

        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        -- set use_icons to true if you have a Nerd Font

        -- TODO: add this
        -- local move = require("mini.move")

        -- TODO: add in mini.icons

        -- TODO: mini.git

        -- TODO: mini-doc ==> auto generate docs?

        -- TODO: mini bufremove

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field

        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
        --

        local colours = require("mini.colors")

        vim.api.nvim_create_user_command("ColourInteractive", function()
            colours.interactive()
        end, { desc = "interactive colour thing" })
    end,
}

-- local createhl = function()
--     local set_default_hl = function(name, data)
--         data.default = true
--         vim.api.nvim_set_hl(0, name, data)
--     end
--     set_default_hl("MiniStatuslineModeNormal", { link = "Cursor" })
--     set_default_hl("MiniStatuslineModeInsert", { link = "DiffChange" })
--     set_default_hl("MiniStatuslineModeVisual", { link = "DiffAdd" })
--     set_default_hl("MiniStatuslineModeReplace", { link = "DiffDelete" })
--     set_default_hl("MiniStatuslineModeCommand", { link = "DiffText" })
--     set_default_hl("MiniStatuslineModeOther", { link = "IncSearch" })
--
--     set_default_hl("MiniStatuslineDevinfo", { link = "StatusLine" })
--     set_default_hl("MiniStatuslineFilename", { link = "StatusLineNC" })
--     set_default_hl("MiniStatuslineFileinfo", { link = "StatusLine" })
--     set_default_hl("MiniStatuslineInactive", { link = "StatusLineNC" })
-- end
--
-- ['n']    = { long = 'Normal',   short = 'N',   hl = 'MiniStatuslineModeNormal' },
-- ['v']    = { long = 'Visual',   short = 'V',   hl = 'MiniStatuslineModeVisual' },
-- ['V']    = { long = 'V-Line',   short = 'V-L', hl = 'MiniStatuslineModeVisual' },
-- [CTRL_V] = { long = 'V-Block',  short = 'V-B', hl = 'MiniStatuslineModeVisual' },
-- ['s']    = { long = 'Select',   short = 'S',   hl = 'MiniStatuslineModeVisual' },
-- ['S']    = { long = 'S-Line',   short = 'S-L', hl = 'MiniStatuslineModeVisual' },
-- [CTRL_S] = { long = 'S-Block',  short = 'S-B', hl = 'MiniStatuslineModeVisual' },
-- ['i']    = { long = 'Insert',   short = 'I',   hl = 'MiniStatuslineModeInsert' },
-- ['R']    = { long = 'Replace',  short = 'R',   hl = 'MiniStatuslineModeReplace' },
-- ['c']    = { long = 'Command',  short = 'C',   hl = 'MiniStatuslineModeCommand' },
-- ['r']    = { long = 'Prompt',   short = 'P',   hl = 'MiniStatuslineModeOther' },
-- ['!']    = { long = 'Shell',    short = 'Sh',  hl = 'MiniStatuslineModeOther' },
-- ['t']    = { long = 'Terminal', short = 'T',   hl = 'MiniStatuslineModeOther' },
--
-- return   { long = 'Unknown',  short = 'U',   hl = '%#MiniStatuslineModeOther#' }
-- return MiniStatusline.combine_groups({
--   { hl = mode_hl,                  strings = { mode } },
--   { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
--   '%<', -- Mark general truncate point
--   { hl = 'MiniStatuslineFilename', strings = { filename } },
--   '%=', -- End left alignment
--   { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
--   { hl = mode_hl,                  strings = { search, location } },
