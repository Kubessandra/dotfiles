local cmp = require("cmp")

local keymap = vim.keymap.set
local saga = require('lspsaga')
saga.init_lsp_saga({
  code_action_lightbulb = {
    enable = false
  }
})

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      local prefix = entry.source.name
      vim_item.menu = prefix
      return vim_item;
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end
    ),
  }),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  })
}

cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

local function server_setup(server, opts)
  opts = opts or {}

  opts.on_attach = function(_, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    keymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
    keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
    keymap('n', 'gr', vim.lsp.buf.references, bufopts)
    keymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
    keymap('n', 'K', vim.lsp.buf.hover, bufopts)
    keymap('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    keymap('n', '<space>rn', '<cmd>Lspsaga rename<cr>', bufopts)
    keymap('n', '<space>ca', '<cmd>Lspsaga code_action<cr>', bufopts)
    keymap('n', '<space>gh', '<cmd>Lspsaga lsp_finder<cr>', bufopts)
    keymap('n', 'gl', vim.diagnostic.open_float, bufopts)
    keymap('n', '[d', vim.diagnostic.goto_prev, bufopts)
    keymap('n', ']d', vim.diagnostic.goto_next, bufopts)
  end

  opts.capabilities = require('cmp_nvim_lsp').default_capabilities()

  local lspconfig = require('lspconfig')
  lspconfig[server].setup(opts)
end

-- LSP Settings
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- Auto complete
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
vim.lsp.handlers.hover,
{
  border = 'rounded',
}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
vim.lsp.handlers.signature_help,
{
  border = 'rounded',
}
)

require('mason').setup({})
require('mason-lspconfig').setup({})
require('mason-lspconfig').setup_handlers({
  function(name)
    server_setup(name, {})
  end
})
