vim.pack.add({ "neovim/nvim-lspconfig" })
vim.pack.add({ "mason-org/mason.nvim" })
vim.pack.add({ "mason-org/mason-lspconfig.nvim" })
vim.pack.add({ "WhoIsSethDaniel/mason-tool-installer.nvim" })
vim.pack.add({ "folke/trouble.nvim" })
vim.pack.add({ "folke/lazydev.nvim" })
vim.pack.add({ "j-hui/fidget.nvim" })

-- Allows extra capabilities provided by nvim-cmp
vim.pack.add({ "hrsh7th/cmp-nvim-lsp" })

-- "williamboman/mason.nvim",
-- "williamboman/mason-lspconfig.nvim",
vim.pack.add({ "hrsh7th/cmp-buffer" })
vim.pack.add({ "hrsh7th/cmp-path" })
vim.pack.add({ "hrsh7th/cmp-cmdline" })
vim.pack.add({ "hrsh7th/nvim-cmp" })

vim.pack.add({ "folke/todo-comments.nvim" })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("QuirkLspGroup", { clear = true }),
    callback = function(event)
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
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
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
    -- texlab = {
    --     cmd = {
    --         vim.fs.joinpath( --
    --             vim.fn.stdpath("data"),
    --             "mason",
    --             "bin",
    --             "texlab",
    --         )
    --     },
    --     filetypes = {
    --         "tex",
    --         "latex",
    --     },
    --
    --     settings = {
    --         texlab = {
    --             -- disable wordwrap for bibtex
    --             formatterLineLength = 0,
    --
    --             --- build args
    --             --- see [docs](https://github.com/latex-lsp/texlab/wiki/Configuration)
    --             build = {
    --                 executable = "latexmk",
    --                 args = {
    --                     "-lualatex",
    --                     "-interaction=nonstopmode",
    --                     "-synctex=1",
    --
    --                     -- "%b.tex",
    --                     "main.tex",
    --                     -- "%f", -- Change this to a `get main file function or "%f"`
    --                 },
    --                 onSave = false,
    --                 forwardSearchAfter = true,
    --             },
    --             bib,
    --         },
    --     },
    -- },
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
            vim.api.nvim_feedkeys("2k$3hi", "n", false)
        end, {
            buffer = true,
            silent = true,
        })
    end,
})
-----⇑ GO ⇑-----
