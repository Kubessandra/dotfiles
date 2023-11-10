---------------------------------
-- Formatting
---------------------------------
local diagnostics = require("null-ls").builtins.diagnostics
local formatting = require("null-ls").builtins.formatting
local code_actions = require("null-ls").builtins.code_actions

require("null-ls").setup({
	sources = {
		diagnostics.eslint_d,
		formatting.prettierd,
    code_actions.refactoring,
    code_actions.eslint_d,
	},
})
