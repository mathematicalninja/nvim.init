return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
      o
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- -- REQUIRED

        vim.keymap.set( --
            "n",
            "<C-e>",
            function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            { desc = "open harpoon menu" }
        )

        vim.keymap.set(
            "n",
            "<leader>a",
            function()
                harpoon:list():add()
            end,
            { desc = "harpoon [a]dd" } --
        )

        vim.keymap.set(
            "n",
            "<leader>t",
            function()
                harpoon:list():select(1)
            end,
            { desc = "harpoon select 1" } -- uses 1st key on left index
        )
        vim.keymap.set(
            "n",
            "<leader>r",
            function()
                harpoon:list():select(2)
            end,
            { desc = "harpoon select 2" } -- uses 2nd key on left index
        )
        vim.keymap.set(
            "n",
            "<leader>e",
            function()
                harpoon:list():select(3)
            end,
            { desc = "harpoon select 3" } -- uses 3rd key on left index
        )
        vim.keymap.set(
            "n",
            "<leader>w",
            function()
                harpoon:list():select(4)
            end,
            { desc = "harpoon select 4" } -- uses 4th key on left index
        )

        vim.keymap.set(
            "n",
            "<leader>q",
            function()
                harpoon:list():select(5)
            end,
            { desc = "harpoon select 5" } -- uses 4th key on left index
        )
        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set( --
            "n",
            "<C-S-J>",
            function()
                harpoon:list():prev()
            end
        )
        vim.keymap.set( --
            "n",
            "<C-S-K>",
            function()
                harpoon:list():next()
            end
        )
    end,
}
