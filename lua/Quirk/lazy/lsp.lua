-- 3 places have LANGUAGE ADDITION mrked on them.lsplslsp
local root_files = {
    ".git",
}
return {

    -- LSP Plugins

    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
        -- system agnostic path joining.
        "mathematicalninja/pathjoin.nvim",

        -- Automatically install LSPs and related tools to stdpath for Neovim
        -- Mason must be loaded before its dependents so we need to set it up here.
        -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`

        -- Allows extra capabilities provided by blink.cmp
        "saghen/blink.cmp",

        -- Formatting, both auto on file save, and as a manual function call.
        "stevearc/conform.nvim",

        -- Automatically install LSPs and related tools to stdpath for Neovim
        { "mason-org/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
        -- mason-lspconfig:
        -- - Bridges the gap between LSP config names (e.g. "lua_ls") and actual Mason package names (e.g. "lua-language-server").
        -- - Used here only to allow specifying language servers by their LSP name (like "lua_ls") in `ensure_installed`.
        -- - It does not auto-configure servers — we use vim.lsp.config() + vim.lsp.enable() explicitly for full control.
        "mason-org/mason-lspconfig.nvim",

        {
            "mason-org/mason-lspconfig.nvim",

            dependencies = {
                "mason-org/mason.nvim",
            },
        },
        -- mason-tool-installer:
        -- - Installs LSPs, linters, formatters, etc. by their Mason package name.
        -- - We use it to ensure all desired tools are present.
        -- - The `ensure_installed` list works with mason-lspconfig to resolve LSP names like "lua_ls".
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        "folke/trouble.nvim",
        {
            -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
            -- used for completion, annotations and signatures of Neovim apis
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        -- Useful status updates for LSP.
        {
            "j-hui/fidget.nvim",
            opts = {
                notification = {
                    window = {
                        winblend = 0, -- Background color opacity in the notification window
                    },
                },
            },
        },

        -- Allows extra capabilities provided by nvim-cmp
        "hrsh7th/cmp-nvim-lsp",

        -- "williamboman/mason.nvim",
        -- "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",

        --

        -- "L3MON4D3/LuaSnip",
        --        "saadparwaiz1/cmp_luasnip",

        -- Comment Highlighting.
        {
            -- Highlight todo, notes, etc in comments
            "folke/todo-comments.nvim",
            event = "VimEnter",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = { signs = false },
        },
    },

    -- Diagnostic Config
    -- See :help vim.diagnostic.Opts
    --		vim.diagnostic.config({
    --			severity_sort = true,
    --			float = { border = "rounded", source = "if_many" },
    --			underline = { severity = vim.diagnostic.severity.ERROR },
    --			signs = vim.g.have_nerd_font and {
    --				text = {
    --					[vim.diagnostic.severity.ERROR] = "󰅚 ",
    --					[vim.diagnostic.severity.WARN] = "󰀪 ",
    --					[vim.diagnostic.severity.INFO] = "󰋽 ",
    --					[vim.diagnostic.severity.HINT] = "󰌶 ",
    --				},
    --			} or {},
    --			virtual_text = {
    --				source = "if_many",
    --				spacing = 2,
    --				format = function(diagnostic)
    --					local diagnostic_message = {
    --						[vim.diagnostic.severity.ERROR] = diagnostic.message,
    --						[vim.diagnostic.severity.WARN] = diagnostic.message,
    --						[vim.diagnostic.severity.INFO] = diagnostic.message,
    --						[vim.diagnostic.severity.HINT] = diagnostic.message,
    --					}
    --					return diagnostic_message[diagnostic.severity]
    --				end,
    --			},
    --		})

    --
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("QuirkLspGroup", { clear = true }),
            callback = function(event)
                -- conform's formatter.
                vim.keymap.set( --
                    "n",
                    "<leader><leader>f",
                    function()
                        require("conform").format({
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
                        require("conform").format({
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
                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                vim.keymap.set(
                    { "n", "x" },
                    "gra",
                    vim.lsp.buf.code_action,
                    { buffer = event.buf, desc = "LSP: " .. "[g]oto code [a]ction" }
                )

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                vim.keymap.set( --
                    "n",
                    "grn",
                    vim.lsp.buf.rename,
                    { buffer = event.buf, desc = "LSP: " .. "[r]e[n]ame" }
                )

                -- Find references for the word under your cursor.
                vim.keymap.set(
                    "n",
                    "grr",
                    require("telescope.builtin").lsp_references,
                    { buffer = event.buf, desc = "LSP: " .. "[g]oto [r]eferences" }
                )

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                vim.keymap.set(
                    "n",
                    "gri",
                    require("telescope.builtin").lsp_implementations,
                    { buffer = event.buf, desc = "LSP: " .. "[g]oto [i]mplementation" }
                )

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                vim.keymap.set(
                    "n",
                    "grd",
                    require("telescope.builtin").lsp_definitions,
                    { buffer = event.buf, desc = "LSP: " .. "[g]oto [d]efinition" }
                )

                -- WARN: This is ***not*** Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                vim.keymap.set(
                    "n",
                    "grD",
                    vim.lsp.buf.declaration,
                    { buffer = event.buf, desc = "LSP: " .. "[g]oto [D]eclaration" }
                )

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                vim.keymap.set(
                    "n",
                    "gro",
                    require("telescope.builtin").lsp_document_symbols,
                    { buffer = event.buf, desc = "LSP: " .. "[o]pen document symbols" }
                )

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                vim.keymap.set(
                    "n",
                    "grw",
                    require("telescope.builtin").lsp_dynamic_workspace_symbols,
                    { buffer = event.buf, desc = "LSP: " .. "open [w]orkspace symbols" }
                )

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                vim.keymap.set(
                    "n",
                    "grt",
                    require("telescope.builtin").lsp_type_definitions,
                    { buffer = event.buf, desc = "LSP: " .. "[g]oto [t]ype definition" }
                )

                --- refactor of function that reconciles v0.10 and v0.11, now *should* just check functionality.
                ---@param client vim.lsp.Client
                ---@param method vim.lsp.protocol.Method
                ---@param bufnr? integer some lsp support methods only in specific files
                ---@return boolean
                local function client_supports_method(client, method, bufnr)
                    return client:supports_method(method, bufnr)
                end

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if
                    client
                    and client_supports_method(
                        client,
                        vim.lsp.protocol.Methods.textDocument_documentHighlight,
                        event.buf
                    )
                then
                    local highlight_augroup = vim.api.nvim_create_augroup("QuirkLspHighlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("QuirkLspDetach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "QuirkLspHighlight", buffer = event2.buf })
                        end,
                    })
                end

                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                --
                -- This may be unwanted, since they displace some of your code
                -- if
                --     client
                --     and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                -- then
                --     vim.keymap.set( --
                --         "n",
                --         "<leader>i",
                --         function()
                --             vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                --         end,
                --         { buffer = event.buf, desc = "LSP: " .. "toggle [i]nlay hints" }
                --     )
                -- end
            end,
        })

        --[[
        Conform:
        
        Formatter, keeps buffer in tact (as much as possible), helps protect against LSPs "over altering" and removing marks/folds etc. from a buffer, can format embedded code.

        Runs multiple formatters subsequently.
        e.g.
        formatters_by_ft = {
            python = { "ruff_format", "isort" },
        }

        Allows Conform.format() as a drop in replacement for vim.lsp.buf.format
        --]]

        require("conform").setup({
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
            notify_on_error = false,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = {
                    -- c = true, cpp = true
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

        -- LSP servers and clients are able to communicate to each other what features they support.
        -- By default, Neovim doesn't support everything that is in the LSP specification.
        -- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        -- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        local servers = {
            -- LANGUAGE ADDITION HERE!
            sqls = {
                filetypes = { "sql" },
            },
            gopls = {
                filetypes = { "go" },
                settings = {
                    gopls = {
                        staticcheck = true,
                    },
                },
            },

            clangd = {
                filetypes = { "c", "h" },
            },
            bashls = {
                cmd = { "bash-language-server", "start" },
                filetypes = { "bash", "sh" },
            },
            texlab = {
                cmd = {
                    require("pathjoin").join({ --
                        vim.fn.stdpath("data"),
                        "mason",
                        "bin",
                        "texlab",
                    }),
                },
                filetypes = {
                    "tex",
                    "latex",
                },

                settings = {
                    texlab = {
                        -- disable wordwrap for bibtex
                        formatterLineLength = 0,

                        --- build args
                        --- see [docs](https://github.com/latex-lsp/texlab/wiki/Configuration)
                        build = {
                            executable = "latexmk",
                            args = {
                                "-lualatex",
                                "-interaction=nonstopmode",
                                "-synctex=1",

                                -- "%b.tex",
                                "main.tex",
                                -- "%f", -- Change this to a `get main file function or "%f"`
                            },
                            onSave = false,
                            forwardSearchAfter = true,
                        },
                        bib,
                    },
                },
            },
            zls = {},
            ruff = {},
            -- pylsp = {
            --     settings = {
            --         pylsp = {
            --             plugins = {
            --                 pyflakes = { enabled = false },
            --                 pycodestyle = { enabled = false },
            --                 autopep8 = { enabled = false },
            --                 yapf = { enabled = false },
            --                 mccabe = { enabled = false },
            --                 pylsp_mypy = { enabled = false },
            --                 pylsp_black = { enabled = false },
            --                 pylsp_isort = { enabled = false },
            --             },
            --         },
            --     },
            -- },
            basedpyright = {
                settings = {
                    basedpyright = {
                        -- BUG:
                        -- remove inline hints
                        pythonPath = vim.fn.system("which python"):gsub("%s+", ""), -- fails on windows systems with spaces in the name.

                        -- disableOrganizeImports = true,

                        analysis = {
                            -- autoImportCompletions = true,
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = "strict",
                            diagnosticMode = "workspace",
                            autoFormatStrings = true,
                            inlayHints = {
                                variableTypes = false,
                                callArgumentNamesMatching = false,
                                callArgumentNames = false,
                            },
                        },
                    },
                },
            },

            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        diagnostics = {
                            globals = { "vim" },
                            disable = { "unused-function" },
                            --	disable = { "missing-fields" },
                        },
                        format = {
                            enable = false,
                        },
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        },
                    },
                },
            },
            tinymist = {
                filetypes = { "typst" },
                command = { "tinymist" },
                settings = {
                    typst = {
                        formatterMode = "typstyle",
                        -- exportPdf = "onType",
                        semanticTokens = "enable",
                    },
                },
            },
            marksman = {},
            biome = {
                settings = {
                    formatter = { --
                        indentStyle = "space",
                        indentWidth = 2,
                        attributePosition = "multiline",
                    },
                    json = {
                        formatter = {
                            enabled = true,
                            indentStyle = "space",
                            indentWidth = 2,
                        },
                    },
                },
            },
        }

        -- Ensure the servers and tools above are installed
        local ensure_installed = vim.tbl_keys(servers or {})
        --TODO: Check that stylua is, indeed, needed.
        vim.list_extend(ensure_installed, {
            "stylua", -- Used to format Lua code
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        for server, cfg in pairs(servers) do
            -- For each LSP server (cfg), we merge:
            -- 1. A fresh empty table (to avoid mutating capabilities globally)
            -- 2. Your capabilities object with Neovim + cmp features
            -- 3. Any server-specific cfg.capabilities if defined in `servers`
            cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})

            vim.lsp.config(server, cfg)
            vim.lsp.enable(server)
        end

        -- ========== go import handling ==========
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                vim.lsp.buf.code_action({
                    context = {
                        only = { "source.organizeImports" },
                        diagnostics = {},
                    },
                    apply = true,
                })
            end,
        })
        -- ========================================

        -- Disable the built-in insert-mode popup and leave only cmp’s menu
        vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
        local cmp = require("cmp")

        cmp.setup({
            sources = cmp.config.sources({
                { name = "blink" },
                { name = "nvim_lsp" },
                -- { name = "luasnip" },
                { name = "buffer" },
            }),
            mapping = {},
            -- experimental = {
            --     ghost_text = true,
            -- },
            completion = {
                autocomplete = false,
            },
        })

        -- Only navigate if the popup is visible
        vim.keymap.set({ "i" }, "<C-j>", function()
            if cmp.visible() then
                cmp.select_next_item()
            elseif true then
                vim.lsp.buf.signature_help()
            end
        end, { desc = "cmp: select down[j] item" })

        vim.keymap.set({ "i" }, "<C-k>", function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif true then
                vim.lsp.buf.hover()
            end
        end, { desc = "cmp: select up[k] item" })

        -- swap to shift in normal mode to allow <C-{j/k}> to move windows
        vim.keymap.set({ "n" }, "<S-j>", function()
            if cmp.visible() then
                cmp.select_next_item()
            elseif true then
                vim.lsp.buf.signature_help()
            end
        end, { desc = "cmp: select down[j] item" })

        vim.keymap.set({ "n" }, "<S-k>", function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif true then
                vim.lsp.buf.hover()
            end
        end, { desc = "cmp: select up[k] item" })

        -- Opens popup if it's not there , otherwise it's confirm.
        vim.keymap.set("i", "<C-l>", function()
            if cmp.visible() then
                cmp.confirm({ select = false })
            else
                cmp.complete()
            end
        end, { desc = "cmp: accept or open" })

        pcall(vim.keymap.del, "i", "<C-h>")
        vim.keymap.set("i", "<C-h>", function()
            if cmp.visible() then
                cmp.abort()
            end
        end, { desc = "cmp: abort" })

        --------------------LANGUAGE ADDITIONS------------------------
        -----⇓ Go ⇓-----
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "go",
            callback = function()
                vim.keymap.set("n", "<leader><leader>e", function()
                    vim.api.nvim_put({ --
                        ------
                        "if err != nil {",
                        "return  err",
                        "}",
                        ------
                    }, "l", true, true)
                    vim.api.nvim_feedkeys("kk$hhhi", "n", false)
                end, {
                    buffer = true,
                    silent = true,
                })
            end,
        })
        -----⇑ GO ⇑-----
    end,
}
--       local cmp = require("cmp")
--
--       local cmp_lsp = require("cmp_nvim_lsp")
--
--       local capabilities = vim.tbl_deep_extend(
--           "force",
--           {},
--           vim.lsp.protocol.make_client_capabilities(),
--           cmp_lsp.default_capabilities()
--           -- cmp.get_lsp_capabilities() -- TODO: check this.
--       )
--       require("fidget").setup({})
--
--       require("mason").setup()
--
--       require("mason-lspconfig").setup({
--           ensure_installed = {
--               "lua_ls",
--               -- "stylua", -- Used to format Lua code
--               "ruff",
--           },
--           handlers = {
--               function(server_name) -- default handler (optional)
--                   require("lspconfig")[server_name].setup({
--                       capabilities = capabilities,
--                   })
--               end,
--
--               ["lua_ls"] = function()
--                   local lspconfig = require("lspconfig")
--                   lspconfig.lua_ls.setup({
--                       capabilities = capabilities,
--                       settings = {
--                           Lua = {
--                               format = {
--                                   enable = true,
--                                   -- Put format options here
--                                   -- NOTE: the value should be STRING!!
--                                   defaultConfig = {
--                                       indent_style = "space",
--                                       indent_size = "2",
--                                   },
--                               },
--                           },
--                       },
--                   })
--               end,
--           },
--       })
--
--       local cmp_select = { behavior = cmp.SelectBehavior.Select }
--
--       cmp.setup({
--           snippet = {
--               expand = function(args)
--                   require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
--               end,
--           },
--           -- TODO: remove Arrow keys from cmp dropdown interaction.
--           mapping = cmp.mapping.preset.insert({
--               --- TODO: |cmp.mapping|
--               ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select), -- up the list.
--               ["<C-j>"] = cmp.mapping.select_next_item(cmp_select), -- Down the list.
--               ["<C-l>"] = cmp.mapping.confirm({ select = true }), -- "right" for finish this "word".
--               ["<C-Space>"] = cmp.mapping.complete(),
--               ["<C-i>"] = cmp.mapping.open_docs({ mapping }),
--               --                ["<C-Enter>"] = cmp.mapping.confirm({select = true})
--           }),
--           sources = cmp.config.sources({
--               { name = "nvim_lsp" },
--               { name = "luasnip" }, -- TODO: look into luasnip
--               -- { name = 'luasnip' }, -- For luasnip users.
--               -- { name = 'snippy' }, -- For snippy users.
--               -- { name = 'ultisnips' }, -- For ultisnips users.
--           }, {
--               { name = "buffer" },
--           }),
--
--           window = {
--               -- completion = cmp.config.window.bordered(),
--               -- documentation = cmp.config.window.bordered(),
--           },
--           view = {},
--           formatting = {},
--       })
--
--       vim.diagnostic.config({
--           -- update_in_insert = true,
--           float = {
--               focusable = false,
--               style = "minimal",
--               border = "rounded",
--               source = "always",
--               header = "",
--               prefix = "",
--           },
--       })
--   end,
-- }
--
--[[
 
-- `/` cmdline setup.
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})
-- `:` cmdline setup.
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')[%YOUR_LSP_SERVER%].setup {
  capabilities = capabilities
}
*cmp.open_docs* ()
  Open docs view.

*cmp.close_docs* ()
  Close docs view.

*cmp.scroll_docs* (delta: number)
  Scroll the documentation window if visible.


  inoremap <C-S> <Cmd>lua require('cmp').complete({ config = { sources = { { name = 'vsnip' } } } })<CR>

  NOTE: `config` in that case means a temporary setting, but `config.mapping` remains permanent.


*cmp.event:on* (%EVENT_NAME%, callback)
  Subscribe to nvim-cmp's event. Events are listed below.

  - `complete_done`: emit after current completion is done.
  - `confirm_done`: emit after confirmation is done.
  - `menu_opened`: emit after opening a new completion menu. Called with a table holding a key
    named `window`, pointing to the completion menu implementation.
  - `menu_closed`: emit after completion menu is closed. Called with a table holding a key
    named `window`, pointing to the completion menu implementation.




  cmp.setup {
    mapping = {
      ['<CR>'] = function(fallback)
        if cmp.visible() then
          cmp.confirm()
        else
          fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
        end
      end
    }
  }

  cmp.setup {
    mapping = {
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end
    }
  }
<
completion.autocomplete~
  `cmp.TriggerEvent[] | false`
  The event to trigger autocompletion. If set to `false`, then completion is
  only invoked manually (e.g. by calling `cmp.complete`).
                                                  *cmp-config.formatting.format*
formatting.format~
  `fun(entry: cmp.Entry, vim_item: vim.CompletedItem): vim.CompletedItem`
  The function used to customize the appearance of the completion menu. See
  |complete-items|. This value can also be used to modify the `dup` property.
  NOTE: The `vim.CompletedItem` can contain the special properties
  `abbr_hl_group`, `kind_hl_group` and `menu_hl_group`.

                                   *cmp-config.matching.disallow_fuzzy_matching*
matching.disallow_fuzzy_matching~
  `boolean`
  Whether to allow fuzzy matching.

                               *cmp-config.matching.disallow_fullfuzzy_matching*
matching.disallow_fullfuzzy_matching~
  `boolean`
  Whether to allow full-fuzzy matching.

                           *cmp-config.matching.disallow_partial_fuzzy_matching*
matching.disallow_partial_fuzzy_matching~
  `boolean`
  Whether to allow fuzzy matching without prefix matching.
                                 *cmp-config.matching.disallow_partial_matching*
matching.disallow_partial_matching~
  `boolean`
  Whether to allow partial matching.

                                *cmp-config.matching.disallow_prefix_unmatching*
matching.disallow_prefix_unmatching~
  `boolean`
  Whether to allow prefix unmatching.

                                cmp-config.matching.disallow_symbol_nonprefix_matching
matching.disallow_symbol_nonprefix_matching
  `boolean`
  Whether to allow symbols in matches if the match is not a prefix match.


TODO: put buffer as the first source in the sources list.
   function(entry: cmp.Entry, ctx: cmp.Context): boolean


  Returning `true` will keep the entry, while returning `false` will remove it.

  This can be used to hide certain entries from a given source. For instance, you
  could hide all entries with kind `Text` from the `nvim_lsp` filter using the
  following source definition:

  {
    name = 'nvim_lsp',
    entry_filter = function(entry, ctx)
      return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
    end
  }
  Using the `ctx` parameter, you can further customize the behaviour of the
  source.
view.entries.follow_cursor~
  `boolean`

  Specify whether the pmenu should follow the current position of the cursor
  as the user types. Custom view only. `false` by default.


                           *cmp-config.window.{completion,documentation}.border*
window.{completion,documentation}.border~
  `string | string[] | nil`
  Border characters used for the completion popup menu when |experimental.native_menu| is disabled.
  See |nvim_open_win|.

                     *cmp-config.window.{completion,documentation}.winhighlight*
window.{completion,documentation}.winhighlight~
  `string | cmp.WinhighlightConfig`
  Specify the window's winhighlight option.
  See |nvim_open_win|.

                     *cmp-config.window.{completion,documentation}.winblend*
window.{completion,documentation}.winblend~
  `string | cmp.WinhighlightConfig`
  Specify the window's winblend option.
  See |nvim_open_win|.

                           *cmp-config.window.{completion,documentation}.zindex*
window.{completion,documentation}.zindex~
  `number`
  The completion window's zindex.
  See |nvim_open_win|.

                                        *cmp-config.window.completion.col_offset*
window.completion.col_offset~
  `number`
  Offsets the completion window relative to the cursor.

                                            *cmp-config.experimental.ghost_text*
experimental.ghost_text~
  `boolean | { hl_group = string }`
  Whether to enable the ghost_text feature.


  The `cmp.config.context` can be used for context-aware completion toggling.

cmp.setup {
  enabled = function()
    -- disable completion if the cursor is `Comment` syntax group.
    return not cmp.config.context.in_syntax_group('Comment')
  end
}



  *cmp.config.context.in_treesitter_capture* (capture)
    You can specify the treesitter capture name.
    If you don't use the `nvim-treesitter` plugin, this helper will not work correctly.
cmp.config.window~

  *cmp.config.window.bordered* (option)
    Make the completion window `bordered`.
    The option is described in `cmp.ConfigSchema`.

    cmp.setup {
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    }
--]]
