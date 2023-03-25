local cmp = require("cmp")

local keymap = vim.keymap.set

local saga = require("lspsaga")

saga.setup({
	code_action_lightbulb = {
		enable = false,
	},
})

local lsp = require('lsp-zero')
lsp.preset('recommended')

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()
lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
})

local cmp_mappings = lsp.defaults.cmp_mappings({
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  formatting = {
    format = function(entry, vim_item)
      local prefix = entry.source.name
      vim_item.menu = prefix
      return vim_item
    end,
  },
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})

lsp.on_attach(function(client, bufnr)
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
		keymap("n", "gd", vim.lsp.buf.definition, bufopts)
		keymap("n", "gr", vim.lsp.buf.references, bufopts)
		keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
		keymap("n", "K", vim.lsp.buf.hover, bufopts)
		keymap("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
		keymap("n", "<space>rn", "<cmd>Lspsaga rename<cr>", bufopts)
		keymap("n", "<space>ca", "<cmd>Lspsaga code_action<cr>", bufopts)
		keymap("n", "<space>gh", "<cmd>Lspsaga lsp_finder<cr>", bufopts)
		keymap("n", "gl", vim.diagnostic.open_float, bufopts)
		keymap("n", "[d", vim.diagnostic.goto_prev, bufopts)
		keymap("n", "]d", vim.diagnostic.goto_next, bufopts)
end)

lsp.setup();

cmp.setup.cmdline(":", {
	sources = {
		{ name = "cmdline" },
	},
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- LSP Settings
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Auto complete
vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})
