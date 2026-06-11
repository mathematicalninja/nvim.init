
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
--
--

return {
make_rel_output_path = make_rel_output_path
,get_compile_path =get_compile_path  

}
