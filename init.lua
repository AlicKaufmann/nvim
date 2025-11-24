-- runtime path
vim.opt.packpath:append("/Users/alickaufmann/nvimplugins")
vim.opt.rtp:append("/opt/homebrew/opt/fzf")


-- lsp
require('config.lsp')

-- plugins
require('plugin.fzf-lua')
require('plugin.nvim-web-devicons')
require('plugin.tokyonight')
require('plugin.nvim-autopairs')
require('plugin.oil')
require('plugin.vim-fugitive')

-- keymaps
require('config.keymaps')

-- require 'lspconfig'.pyright.setup {}


-- nvim-dap-python
-- require("dap-python").setup("/Users/alickaufmann/Documents/programming/python-test-project")
-- vim.api.nvim_set_keymap('n', '<leader>db', [[:lua require"dap".toggle_breakpoint()<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dc', [[:lua require"dap".continue()<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>do', [[:lua require"dap".step_over()<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>di', [[:lua require"dap".step_into()<CR>]], { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dh', [[:lua require"dap.ui.widgets".hover()<CR>]], { noremap = true })
