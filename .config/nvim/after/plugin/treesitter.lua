require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
  context_commentstring = {
    enable = false
  }
}

require'ts_context_commentstring'.setup {}
