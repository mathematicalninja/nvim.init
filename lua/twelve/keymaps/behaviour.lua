-- void pasting
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("v", "p", [["_dP]])
-- void delete
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<leader>D", '"_D')
-- void change
vim.keymap.set({ "n", "v" }, "<leader>c", '"_c')
vim.keymap.set({ "n", "v" }, "<leader>C", '"_C')

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- :BUG: this does [["+yy]] for some reason.
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- sets mark a (ma) formats (=) around paragraph (ap) moves back to mark a ('a) rather than leaving cursor at top of paragraph.
vim.keymap.set("n", "=ap", "ma=ap'a")

-- project view ==> Oil handles this now
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- for fun
-- vim.keymap.set("n", "<leader>ca", function()
-- 	require("cellular-automaton").start_animation("make_it_rain")
-- end)

-- insert mode save.
vim.keymap.set({ "n", "i" }, "<C-s>", "<CMD>w<CR>")

-- lua sourcing to avoid accidental `:sp` doing a split
vim.keymap.set("n", "<leader><leader>s", "<CMD>so<CR>", { desc = "lua/vim [s]orcing to avoid accidental `:sp`" })

vim.keymap.set("n", "<leader>k", function()
    vim.diagnostic.open_float()
end, { desc = "look up[k] at diagnostics" })

-- old
-- vim.keymap.set("n", "<leader>j", "z=", { desc = "correct word under[j] cursor" })

-- new
vim.keymap.set("n", "<leader>j", function()
    local word = vim.fn.expand("<cword>")
    local suggestions = vim.fn.spellsuggest(word, 4)
    if #suggestions == 0 then
        return
    end
    vim.ui.select(suggestions, {
        prompt = "Spelling",
    }, function(choice)
        if choice then
            vim.cmd("normal! ciw" .. choice)
        end
    end)
end, { desc = "Correct word under[j] cursor." })

-- fed up of "s" in the middle of a messed up key combination deleting things.
-- And I don't need an abbreviation for a 2 letter code.
vim.keymap.set("n", "s", "<nop>", { desc = "remove cl alias" })
vim.keymap.set("n", "S", "<nop>", { desc = "remove cc alias" })

-- instant folds
vim.keymap.set( --
    "n",
    "<leader><leader>z",
    "v%:fold<CR>",
    { desc = "create a matching pair fold, and close it." }
)

-- *really* close a buffer
vim.keymap.set( --
    "n",
    "<leader><C-Q>",
    "<CMD>bd<CR>",
    { desc = "[Q]uits a buffer using buffer-delete" }
)

-- Undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[u]ndo tree toggle}" })
