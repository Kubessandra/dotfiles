---------------------------------
-- Formatting
---------------------------------
local diagnostics = require("null-ls").builtins.diagnostics
local formatting = require("null-ls").builtins.formatting

require("null-ls").setup({
	sources = {
		diagnostics.eslint,
		formatting.prettierd,
		formatting.stylua,
	},
})
