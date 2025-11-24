vim.pack.add({ "https://github.com/stevearc/oil.nvim.git" })
require("oil").setup({
	keymaps = {
		["cd"] = "actions.cd"
	},
	view_options = {
		show_hidden = true
	}
})
