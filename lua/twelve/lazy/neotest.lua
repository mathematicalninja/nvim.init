return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",

        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim", -- git clone error.
        "nvim-treesitter/nvim-treesitter",

        { "nvim-neotest/neotest-python", lazy = false },
        { "nvim-neotest/neotest-go", lazy = false },
        "nvim-neotest/neotest-plenary",
        "nvim-neotest/neotest-vim-test",
    },
    lazy = false,
    init = function()
        vim.schedule(function()
            print("NEOTESTING")
            --{{{ ====== nvim ======
            -- require("neotest-plenary"),
            -- require("neotest-vim-test")({
            --     ignore_file_types = { "python", "vim", "lua" },
            -- }),
            -- }}}
            --{{{ ====== Python ======
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                        python = function()
                            -- Grab the Python currently active in PATH (allows Conda environments etc.)
                            return vim.fn.system("which python"):gsub("%s+", "")
                        end,
                    }),
                    --}}}
                    --{{{ ====== Go ======
                    require("neotest-go")({
                        experimental = {
                            test_table = true,
                        },
                        args = { "-count=1", "-timeout=60s" },
                        recursive_run = true,
                    }),
                    --}}}
                },
                status = { virtual_text = true },
            })

            --{{{ ====== Keymaps ======
            vim.keymap.set("n", "<leader>it", function()
                require("neotest").run.run()
            end, { desc = "test[i]ng [t]his" })
            vim.keymap.set("n", "<leader>if", function()
                require("neotest").run.run(vim.fn.expand("%"))
            end, { desc = "test[i]ng current [f]ile" })
            vim.keymap.set("n", "<leader>id", function()
                require("neotest").run.stop()
            end, { desc = "test[i]ng stop[d]" })
            vim.keymap.set("n", "<leader>io", function()
                require("neotest").output.open({ enter = true })
            end, { desc = "test[i]ng [o]pen" })
            vim.keymap.set("n", "<leader>is", function()
                require("neotest").summary.toggle()
            end, { desc = "test[i]ng [s]ummary" })

            vim.keymap.set("n", "<leader>iA", function()
                require("neotest").run.run({ suite = true })
            end, { desc = "testi[i]ng [A]ll files, recursivly" })
            --}}}
        end)
    end,
}
