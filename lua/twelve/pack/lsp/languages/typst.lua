local M = function(language_tools)
    -- TODO: 1. "Get FILENAME"
    --       2. Make a "get *.typ file __location__" function
    --       3. Use this to check if location/png location/pdf exists.
    --       4. OnSave() ==>
    --          a. If location/pdf exists, compile pdf there
    --             Else compile to location/[FILENAME].pdf
    --          b. If location/png exits compile png there.
    --       5. "Force png" <leader><leader>p ==> if location/png/ use that, else use location/[FILENAME].png

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
                language_tools.utils.get_compile_path(args.buf, "pdf"),
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
                    language_tools.utils.get_compile_path(args.buf, "png"),
                }, { detach = true })
            end, { buffer = args.buf, desc = "Typst .png output" })
        end,
    })
end

return M
