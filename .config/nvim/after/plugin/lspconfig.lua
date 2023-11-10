local cmp = require("cmp")

local keymap = vim.keymap.set

local saga = require("lspsaga")

saga.setup({
	code_action_lightbulb = {
		enable = false,
	},
})

local lsp = require('lsp-zero')

local lua_opts = lsp.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

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

local cmp_format = require('lsp-zero').cmp_format()
cmp.setup({
  mapping = cmp_mappings,
  formatting = {
    format = function(entry, vim_item)
      local prefix = entry.source.name
      vim_item.menu = prefix
      return vim_item
    end,
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert',
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
		keymap("n", "<space>gh", "<cmd>Lspsaga finder<cr>", bufopts)
		keymap("n", "gl", vim.diagnostic.open_float, bufopts)
		keymap("n", "[d", vim.diagnostic.goto_prev, bufopts)
		keymap("n", "]d", vim.diagnostic.goto_next, bufopts)
end)

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

lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = ''
})

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
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

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer'},
  handlers = {
    lsp.default_setup,
  }
})
