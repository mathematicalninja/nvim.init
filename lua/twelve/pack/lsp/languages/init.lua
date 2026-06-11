local M = function(language_tools)
    require("twelve.pack.lsp.languages.typst")(language_tools)
    require("twelve.pack.lsp.languages.latex")(language_tools)
    require("twelve.pack.lsp.languages.python")(language_tools)
    require("twelve.pack.lsp.languages.lua")(language_tools)
end

return M
