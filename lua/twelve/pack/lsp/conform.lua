vim.pack.add({ gh("stevearc/conform.nvim") })

local conform = require("conform")

-- conform's formatter.
vim.keymap.set( --
    "n",
    "<leader><leader>f",
    function()
        conform.format({
            async = true,
            lsp_format = "fallback",
            bufnr = 0, -- current buffer is bufnr 0
        })
    end,
    { desc = "[f]ormat buffer" }
)
vim.keymap.set( --
    "i",
    "<C-f>",
    function()
        conform.format({
            async = true,
            lsp_format = "fallback",
            bufnr = 0, -- current buffer is bufnr 0
        })
    end,
    { desc = "[f]ormat buffer" }
)
--[[ doesn't format correctly.
                vim.keymap.del("i", "<C-f>")
                vim.keymap.set( --
                    "i",
                    "<C-f>",
                    function()
                        require("conform").format({
                            async = true,
                            lsp_format = "fallback",
                            bufnr = 0, -- current buffer is bufnr 0
                        })
                    end,
                    { desc = "[f]ormat buffer" }
                )
                -- ]]

conform.setup({
    --{{{ moved to by language
    formatters_by_ft = {
        -- LANGUAGE ADDITION HERE!
        -- NOTE:Formatters may not share names with LSP clients.
        python = { "ruff_format" },
        lua = { "stylua" },
        c = { "clang-format" },
        zig = { "zigfmt" },
        latex = { "tex-fmt" },
        go = { "gofumpt" },
        sql = { "sqlfluff" },

        -- @see https://biomejs.dev/internals/language-support/
        ["javascript"] = { "biome" },
        ["javascriptreact"] = { "biome" },
        ["typescript"] = { "biome" },
        ["typescriptreact"] = { "biome" },
        ["json"] = { "biome" },
        -- ["jsonc"] = { "biome" },
        ["vue"] = { "biome" },
        ["css"] = { "biome" },
        ["scss"] = { "biome" },
        ["less"] = { "biome" },
        ["html"] = { "biome" },
    },
    -- Conform can also run multiple formatters sequentially
    -- python = { "isort", "black" },

    -- You can use 'stop_after_first' to run the first available formatter from the list
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
    formatters = {
        -- LANGUAGE ADDITION HERE!
        stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
        },
        ["clang-format"] = { prepend_args = { "-i", "--style=Google" } },

        ["tex-fmt"] = {
            append_args = { "--nowrap" },
        },
    },
    --}}}
    notify_on_error = false,
    format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't have a well standardized coding style. You can add additional languages here or re-enable it for the disabled ones.
        local disable_filetypes = {
            -- LANGUAGE ADDITION HERE (disable fallback format)
            c = true,
            cpp = true,
        }
        if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
        else
            return {
                timeout_ms = 1000,
                lsp_format = "fallback",
            }
        end
    end,
})
