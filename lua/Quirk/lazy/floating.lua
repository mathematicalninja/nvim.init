--map(n, <l><l>t , toggle.openfile(./TODO.md)
--IDEA: have "v" mode yank, open scratch, put. Then "n" mode can use toggle_hide. Both on the same keymap.
return {
    "mathematicalninja/floating.nvim",
    dir = "~/Code/nvim/floating",
    config = function()
        local opts = {
            dev = false,
            positions = {
                --{{{ clock_cursor
                clock_cursor = function()
                    --- @module "floating"

                    --- @alias position_abrv
                    --- | "clock_cursor"

                    --- @type Setup_Opts
                    ---@type config_and_position
                    local R = {}

                    -- local col = math.floor(vim.o.columns / 2) - 3
                    -- local row = math.floor(vim.o.lines / 2) - 1

                    local row = -1
                    local col = 0

                    R.pos = "clock_cursor"
                    R.name_location = "footer"
                    R.config = {
                        width = 5,
                        height = 1,
                        col = col,
                        row = row,
                        anchor = "NW",
                        title = "",
                        title_pos = "center",
                        relative = "cursor",
                        style = "minimal", -- No extra UI elements, e.g. status bar.
                        border = { "╔", " ", "╗", " ", "╝", " ", "╚", "█" },
                    }

                    return R
                end, --}}}
            },
            styles = {
                --{{{ clock_cursor
                clock_cursor = {
                    --- @alias style_name
                    --- | "clock_cursor"

                    name = "clock_cursor",
                    positions = { "clock_cursor" },
                    dont_focus = true,

                    INIT = function(FLOAT)
                        FLOAT.state.style_data.clock_cursor = {}
                    end,

                    setup = function(STATE)
                        local time_offset = 8
                        local time_table = os.date("*t", os.time() + time_offset * 3600)

                        local M = tonumber(time_table.min)
                        local H = tonumber(time_table.hour)

                        local digits = {
                            ["0"] = "🯰",
                            ["1"] = "🯱",
                            ["2"] = "🯲",
                            ["3"] = "🯳",
                            ["4"] = "🯴",
                            ["5"] = "🯵",
                            ["6"] = "🯶",
                            ["7"] = "🯷",
                            ["8"] = "🯸",
                            ["9"] = "🯹",
                        }

                        local min = string.format("%02d", M)
                        local min_array = {
                            digits[string.sub(min, 1, 1)],
                            digits[string.sub(min, 2, 2)],
                        }

                        local hour = string.format("%02d", H)
                        local hour_array = {
                            digits[string.sub(hour, 1, 1)],
                            digits[string.sub(hour, 2, 2)],
                        }

                        local time = hour_array[1] .. hour_array[2] .. ":" .. min_array[1] .. min_array[2]

                        STATE.style_data.clock_cursor = {
                            time = time,
                        }
                    end,

                    -- `style` is run after the new window is opened.
                    style = function(opts)
                        local buf = opts.bufwin.buf
                        vim.api.nvim_buf_set_lines( --
                            buf,
                            0,
                            -1,
                            false,
                            { opts.state.style_data.clock_cursor.time }
                        )
                    end,
                },
                --}}}
                --{{{ terminal
                terminal = {
                    --- @alias style_name
                    --- | "terminal"

                    name = "terminal",
                    positions = { "mc" },
                    dont_focus = false,

                    INIT = function(FLOAT)
                        FLOAT.state.style_data.terminal = {}
                    end,

                    setup = function(STATE) end,

                    -- `style` is run after the new window is opened.
                    style = function(opts)
                        vim.api.nvim_cmd({ cmd = "terminal" }, {})
                        local enterPy = vim.api.nvim_replace_termcodes("ipython<CR>", true, false, true)
                        vim.api.nvim_feedkeys(enterPy, "n", true)
                    end,
                },
                --}}}
            },
            extras = { --
                positions = { "clock_tl" },
                styles = { "clock_tl" },
            },
            dont_load_default_user_commands = false,
            dont_use_default_keymaps = false,
        }
        local float = require("floating").setup(opts)

        vim.keymap.set("n", "<leader><leader>k", function()
            float.toggle("clock_cursor")
        end, {})

        vim.keymap.set("n", "<leader><leader>i", function()
            float.toggle("terminal", { pos = "tr" })
        end, {})
        vim.keymap.set("n", "<leader>fi", function()
            float.toggle("terminal", { pos = "tr" })
        end, {})

        vim.keymap.set("n", "<leader>f<leader>f", function()
            float.toggle_hide("default")
        end, { desc = "hide for temp notes" })
    end,
}
