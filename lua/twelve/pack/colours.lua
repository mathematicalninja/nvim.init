vim.pack.add({gh("catppuccin/nvim")})
require("catppuccin").setup({
    color_overrides = {
        -- all = { base = "#000000" },
        mocha = {
            -- 	### defaults ###
            -- 	rosewater = "#dc8a78",
            -- 	flamingo = "#dd7878",
            -- 	pink = "#ea76cb",
            -- 	mauve = "#8839ef",
            -- 	red = "#d20f39",
            -- 	maroon = "#e64553",
            -- 	peach = "#fe640b",
            -- 	yellow = "#df8e1d",
            -- 	green = "#40a02b",
            --  teal = "#f07cd8",
            -- 	sky = "#04a5e5",
            -- 	sapphire = "#209fb5",
            -- 	blue = "#1e66f5",
            -- 	lavender = "#7287fd",
            -- 	text = "#4c4f69",
            -- 	subtext1 = "#5c5f77",
            -- 	subtext0 = "#6c6f85",
            -- 	overlay2 = "#7c7f93",
            -- 	overlay1 = "#8c8fa1",
            -- 	overlay0 = "#9ca0b0",
            -- 	surface2 = "#acb0be",
            -- 	surface1 = "#bcc0cc",
            -- 	surface0 = "#ccd0da",
            -- 	base = "#eff1f5",
            -- 	mantle = "#e6e9ef",
            -- 	crust = "#dce0e8",

            -- ### tweaks ###
            maroon = "#df8e1d", -- parameter
            yellow = "#950054", -- (currently orange) -- types
            -- rosewater = "#00ff00",
            -- flamingo = "#00ff00",
            -- pink = "#f07ce8",
            -- pink = "#00ff00", -- builtins?
            mauve = "#00c2c3", -- Keywords
            red = "#C52A00", -- Errors etc.
            green = "#009d1e", -- Strings
            -- lavender = "#ff00d6", -- elements
            lavender = "#ff61e2", -- elements
            -- peach = "#d7003b", -- Globals / import
            peach = "#b200f7", -- Globals / import, ints
            -- teal = "#00ff00",
            -- sky = "#99ddff", -- operators
            -- sky = "#00ff00",
            -- sapphire = "#00ff00",
            -- blue = "#00ff00",
            blue = "#307cd8", -- Status bar: Normal mode, borders
            -- text = "#f07ce8",
            -- text = "#0055bb", -- variables, cursor, dropdown
            subtext1 = "#00ff00", -- Statusline git/filetype text
            -- subtext0 = "#f07ce8",
            -- subtext0 = "#00ff00",
            -- overlay2 = "#7b306a", -- comment text
            overlay2 = "#ffffff", -- comment text
            -- overlay1 = "#00ff00",
            -- overlay0 = "#00ff00",
            -- surface2 = "#00ff00",
            surface1 = "#3b144a", -- line numbers/ hover tabs, git section of statusline
            surface0 = "#2d0039", -- horizontal line
            -- base = "#2c004c",
            base = "#000000",
            mantle = "#260525", -- vertical line
            crust = "#250832",
        },

        -- flavour = "auto", -- latte, frappe, macchiato, mocha
        -- background = { -- :h background
        --     light = "latte",
        --     dark = "mocha",
        -- },
        -- transparent_background = false, -- disables setting the background color.
        -- float = {
        --     transparent = false, -- enable transparent floating windows
        --     solid = false, -- use solid styling for floating windows, see |winborder|
        -- },
        -- show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        -- term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        -- dim_inactive = {
        --     enabled = false, -- dims the background color of inactive window
        --     shade = "dark",
        --     percentage = 0.15, -- percentage of the shade to apply to the inactive window
        -- },
        -- no_italic = false, -- Force no italic
        -- no_bold = false, -- Force no bold
        -- no_underline = false, -- Force no underline
        -- styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        --     comments = { "italic" }, -- Change the style of comments
        --     conditionals = { "italic" },
        --     loops = {},
        --     functions = {},
        --     keywords = {},
        --     strings = {},
        --     variables = {},
        --     numbers = {},
        --     booleans = {},
        --     properties = {},
        --     types = {},
        --     operators = {},
        --     -- miscs = {}, -- Uncomment to turn off hard-coded styles
        -- },
        -- lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
        --     virtual_text = {
        --         errors = { "italic" },
        --         hints = { "italic" },
        --         warnings = { "italic" },
        --         information = { "italic" },
        --         ok = { "italic" },
        --     },
        --     underlines = {
        --         errors = { "underline" },
        --         hints = { "underline" },
        --         warnings = { "underline" },
        --         information = { "underline" },
        --         ok = { "underline" },
        --     },
        --     inlay_hints = {
        --         background = true,
        --     },
        -- },
        -- color_overrides = {},
        custom_highlights = function(colors)
            return {
                -- Comment = { fg = colors.base },
                -- TabLineSel = { bg = colors.pink },
                -- CmpBorder = { fg = colors.surface2 },
                -- Pmenu = { bg = colors.none },
            }
        end,
        -- custom_highlights = {},
        default_integrations = true,
        auto_integrations = true,
        -- integrations = {
        --     cmp = true,
        --     gitsigns = true,
        --     nvimtree = true,
        --     notify = false,
        --     mini = {
        --         enabled = true,
        --         indentscope_color = "",
        --     },
        --     -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        -- },
        -- highlight_overrides = {
        --     mocha = function(mocha)
        --         return {
        --             -- Comment = { fg = mocha.blue },
        --         }
        --     end,
        -- },
    },
    transparent_background = true,
    float = { transparent = true, solid = false },
    auto_integrations = true,
})
-- Load the colorscheme here.
-- Like many other themes, this one has different styles, and you could load
-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
vim.cmd.colorscheme("catppuccin")
