local nnoremap = require("kube.keymap").nnoremap

nnoremap("<leader>dt", "<cmd>Ex<CR>")

nnoremap("<leader>ff", "<cmd>Telescope find_files hidden=true<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope file_browser<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")

-- Git
nnoremap("<leader>gd", "<cmd>Gitsigns preview_hunk_inline<cr>")

-- Copy current path
nnoremap("<leader>cp", '<cmd>let @+ = expand("%")<cr>')

-- Window
nnoremap("<leader>w", "<C-w>")

-- buffers
nnoremap("<leader>2", "<C-^>")
nnoremap("<leader>oo", "<cmd>:lua vim.lsp.buf.format({ timeout = 3000 })<cr>")
