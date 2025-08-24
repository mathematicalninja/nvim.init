return {
    --[[
        Oil.nvim is a file "explorer" that lets you use buffer style commands to edit the file system.
        --]]
    "stevearc/oil.nvim",

    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    keys = {
        {
            "<leader>pv",
            function()
                require("oil").open()
            end,
            desc = "[p]roject [v]iew",
        },
    },
}
