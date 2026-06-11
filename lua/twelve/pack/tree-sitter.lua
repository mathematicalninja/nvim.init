vim.pack.add({
    gh("nvim-treesitter/nvim-treesitter")
},{ 
    branches={"main"}
})

local opts ={
    ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "latex",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
} 

local TS = require("nvim-treesitter")

TS.setup(opts)
