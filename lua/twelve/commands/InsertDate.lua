vim.api.nvim_create_user_command("Today", function()
    local table = os.date("*t")
    --
    local weekday = os.date("%A")
    local day = table.day
    --
    local month = table.month
    local monthName = os.date("%B")
    --
    local year = table.year
    --
    local suffix = "th"
    if day % 10 == 1 and day ~= 11 then
        suffix = "st"
    elseif day % 10 == 2 and day ~= 12 then
        suffix = "nd"
    elseif day % 10 == 3 and day ~= 13 then
        suffix = "rd"
    end

    local formatted = string.format( --
        "%s %d%s of %s %s",
        weekday,
        day,
        suffix,
        monthName,
        year
    )

    vim.api.nvim_put({ formatted }, "c", true, true)
end, { desc = "Insert current date in human readable form" })

vim.api.nvim_create_user_command("TD", function()
    local table = os.date("*t")
    --
    local weekday = os.date("%A")
    local day = table.day
    --
    local month = table.month
    local monthName = os.date("%B")
    --
    local year = table.year
    --
    local suffix = "th"
    if day % 10 == 1 and day ~= 11 then
        suffix = "st"
    elseif day % 10 == 2 and day ~= 12 then
        suffix = "nd"
    elseif day % 10 == 3 and day ~= 13 then
        suffix = "rd"
    end

    local formatted = string.format( --
        "= %s %d%s of %s %s | (%04d-%02d-%02d)",
        -- human format
        weekday,
        day,
        suffix,
        monthName,
        year,
        --- ISO date
        year,
        month,
        day
    )

    vim.api.nvim_put({ formatted }, "l", false, true)
end, { desc = "Insert current date (newline) in full format" })

vim.api.nvim_create_user_command("InsertDateLine", function()
    local table = os.date("*t")
    --
    local weekday = os.date("%A")
    local day = table.day
    --
    local month = table.month
    local monthName = os.date("%B")
    --
    local year = table.year
    --
    local suffix = "th"
    if day % 10 == 1 and day ~= 11 then
        suffix = "st"
    elseif day % 10 == 2 and day ~= 12 then
        suffix = "nd"
    elseif day % 10 == 3 and day ~= 13 then
        suffix = "rd"
    end

    local formatted = string.format( --
        "= %s %d%s of %s %s | (%04d-%02d-%02d)",
        -- human format
        weekday,
        day,
        suffix,
        monthName,
        year,
        --- ISO date
        year,
        month,
        day
    )

    vim.api.nvim_put({ formatted }, "l", false, true)
end, { desc = "Insert current date (newline) in full format" })

vim.api.nvim_create_user_command("Todate", function()
    local table = os.date("*t")
    --
    local weekday = os.date("%A")
    local day = table.day
    --
    local month = table.month
    local monthName = os.date("%B")
    --
    local year = table.year
    --
    local suffix = "th"
    if day % 10 == 1 and day ~= 11 then
        suffix = "st"
    elseif day % 10 == 2 and day ~= 12 then
        suffix = "nd"
    elseif day % 10 == 3 and day ~= 13 then
        suffix = "rd"
    end

    local formatted = string.format( --
        "= %s %d%s of %s %s | (%04d-%02d-%02d)",
        -- human format
        weekday,
        day,
        suffix,
        monthName,
        year,
        --- ISO date
        year,
        month,
        day
    )

    vim.api.nvim_put({ formatted }, "c", false, true)
end, { desc = "Insert current date (inline) in full format" })
