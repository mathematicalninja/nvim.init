local M = function(language_tools)
    -- Grab the Python currently active in PATH (allows Conda environments etc.)
    local py_path = vim.fn.system("which python"):gsub("%s+", "") -- fails on windows systems with spaces in the name.

    -- Make Neovim use the active env’s Python
    vim.g.python3_host_prog = py_path
    vim.g.python_host_prog = py_path
end

return M
