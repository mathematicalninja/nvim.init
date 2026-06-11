local function FoldAroundFile()
    -- vim.api.
end
vim.api.nvim_create_user_command(
    "FoldAroundFile",
    FoldAroundFile,
    { desc = "creates a fold mark around the current file, with filename." }
)
