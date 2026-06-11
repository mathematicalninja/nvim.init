--  TODO: change config.setup --> opts = {}
return {
    "nat-418/boole.nvim",

    config = function()
        require("boole").setup({
            mappings = {
                increment = "<C-a>",
                decrement = "<C-x>",
            },
            -- User defined loops
            additions = {
                -- { "==", "~=", "!=" }, --- fails?
                -- { "☐", "🗹", "🗷" }, -- fails for some reason?
                -- { "tic", "tac", "toe" },
                -- { "- [ ] ", "- [x] " }, -- idk man, something weird
            },
            allow_caps_additions = {
                { "enable", "disable" },
                -- { "C", "B", "A", "S" },
                -- { "-", "⬤", "✓" }, -- there seems to be an error with ascii characters.
                -- enable → disable
                -- Enable → Disable
                -- ENABLE → DISABLE
            },
        })
    end,
}
