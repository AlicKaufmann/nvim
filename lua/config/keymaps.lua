-- leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- fzf
vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fh", require("fzf-lua").helptags, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fk", require("fzf-lua").keymaps, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fb", require("fzf-lua").builtin, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers, { noremap = true, silent = true })




-- vim.keymap.set("n", "grr", function()
-- 	require("fzf-lua").lsp_references()
-- end, { noremap = true, silent = true })
