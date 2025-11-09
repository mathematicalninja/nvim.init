--IDEA: have "v" mode yank, open scratch, put. Then "n" mode can use toggle_hide. Both on the same keymap.
return {
    "mathematicalninja/floating.nvim",
    config = function()
        local opts = {
            dev = false,
            positions = {
                clock_mid = function()
                    --- @module "floating"

                    --- @alias position_abrv
                    --- | "clock_mid"

                    --- @type Setup_Opts
                    ---@type config_and_position
                    local R = {}

                    local col = math.floor(vim.o.columns / 2) - 3
                    local row = math.floor(vim.o.lines / 2) - 1

                    R.pos = "clock_mid"
                    R.name_location = "footer"
                    R.config = {
                        width = 5,
                        height = 1,
                        col = col,
                        row = row,
                        anchor = "NW",
                        title = "",
                        title_pos = "center",
                        relative = "editor",
                        style = "minimal", -- No extra UI elements, e.g. status bar.
                        border = { "╔", " ", "╗", " ", "╝", " ", "╚", " " },
                    }

                    return R
                end,
            },
            styles = {
                clock_mid = {
                    --- @alias style_name
                    --- | "clock_mid"

                    name = "clock_mid",
                    positions = { "clock_mid" },
                    dont_focus = true,

                    INIT = function(FLOAT)
                        FLOAT.state.style_data.clock_tl = {}
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

                        STATE.style_data.clock_tl = {
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
                            { opts.state.style_data.clock_tl.time }
                        )
                    end,
                },
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
            float.toggle("clock_mid")
        end, {})
    end,
}
