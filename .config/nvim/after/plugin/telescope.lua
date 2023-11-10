require('telescope').setup {
  defaults = {
    file_ignore_patterns = { ".git/" },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
    }
  },
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
