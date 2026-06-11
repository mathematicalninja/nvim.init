--{{{ compile path utils

---@param filename string
---@param rel_dir string
---@param old_file_ext string
---@param new_file_ext string
local make_rel_output_path = function(filename, rel_dir, old_file_ext, new_file_ext)
    local output_name = filename:gsub("%." .. old_file_ext .. "$", "." .. new_file_ext)
    local output_dir = rel_dir
    if vim.uv.fs_stat(vim.fs.joinpath(rel_dir, new_file_ext)) then
        output_dir = vim.fs.joinpath(rel_dir, new_file_ext)
    end
    local output_path = vim.fs.joinpath(output_dir, output_name)
    return output_path
end

---@param bufnum integer
---@param new_ext string
---@return string "target path to compile to."
local get_compile_path = function(bufnum, new_ext)
    local fullpath = vim.api.nvim_buf_get_name(bufnum)
    local cwd = vim.loop.cwd()

    local relpath = vim.fs.relpath(cwd, fullpath)
    local rel_dir = vim.fs.dirname(relpath)

    local filename = vim.fs.basename(fullpath)

    return make_rel_output_path(filename, rel_dir, "typ", new_ext)
end
--}}}

--
-- TODO: 1. "Get FILENAME"
--       2. Make a "get *.typ file __location__" function
--       3. Use this to check if location/png location/pdf exists.
--       4. OnSave() ==>
--          a. If location/pdf exists, compile pdf there
--             Else compile to location/[FILENAME].pdf
--          b. If location/png exits compile png there.
--       5. "Force png" <leader><leader>p ==> if location/png/ use that, else use location/[FILENAME].png
--{{{ Typst
vim.filetype.add({
    extension = {
        typ = "typst",
        typst = "typst",
    },
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.typ",
    callback = function(args)
        local file = args.file

        -- TODO: check if .../pdf exists, and do a png compile if it does
        -- vim.uv.fs_stat(path)

        -- actually compile
        vim.fn.jobstart({
            "typst", --
            "compile",
            file,
            get_compile_path(args.buf, "pdf"),
        }, { detach = true })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    callback = function(args)
        vim.keymap.set("n", "<leader><leader>p", function()
            local file = args.file

            vim.fn.jobstart({
                "typst",
                "compile",
                file,
                get_compile_path(args.buf, "png"),
            }, { detach = true })
        end, { buffer = args.buf, desc = "Typst .png output" })
    end,
})

--}}}

--{{{ LaTeX
vim.filetype.add({
    extension = {
        tex = "latex",
    },
})
--}}}
--{{{ Python
-- Grab the Python currently active in PATH (allows Conda environments etc.)
local py_path = vim.fn.system("which python"):gsub("%s+", "") -- fails on windows systems with spaces in the name.

-- Make Neovim use the active env’s Python
vim.g.python3_host_prog = py_path
vim.g.python_host_prog = py_path
--}}}
