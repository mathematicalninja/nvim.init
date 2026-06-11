vim.api.nvim_create_user_command("PutUnicode", function(opts1)
    ---@type string
    local s
    if opts1.args == nil then
        s = "0000"
    else
        s = opts1.args
    end

    local code = tonumber(s, 16)
    local word = vim.fn.nr2char(code)

    vim.api.nvim_put({ word }, "c", true, true)
end, { nargs = 1, desc = "puts the unicode under the cursor." })
