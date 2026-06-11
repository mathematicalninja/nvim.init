local M = function(language_tools)
    vim.filetype.add({
        extension = {
            tex = "latex",
        },
    })
end

return M
