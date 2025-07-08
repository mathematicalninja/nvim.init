vim.lsp.config("ruff", {
	init_options = {

		settings = {
			-- https://docs.astral.sh/ruff/rules
			-- Ruff Language server settings go here
		},
	},
})
vim.lsp.enable("ruff")
