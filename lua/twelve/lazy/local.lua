local local_plugins = {
    -- "mathematicalninja/todo.nvim",
    -- dir = "~/Code/nvim/todo",
    -- opts = { path_to_todos = "~/.config/.notes/.secrets/todo/" },

    { --
        "mathematicalninja/utfInput.nvim",
        dir = "~/Code/nvim/utfInput",
        -- opts = { dev = false },
    },
    { --
        "mathematicalninja/learnXinYminutes.nvim",
        dir = "~/Code/nvim/learnXinYminutes",
        opts = { dev = false },
    },

    { --
        "mathematicalninja/oklch.nvim",
        dir = "~/Code/nvim/oklab",
        opts = { dev = true },
    },
}

return local_plugins
