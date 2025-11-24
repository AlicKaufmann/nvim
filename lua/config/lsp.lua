vim.lsp.config['lua_ls'] = {
	-- Command and arguments to start the server.
	cmd = { 'lua-language-server' },
	-- Filetypes to automatically attach to.
	filetypes = { 'lua' },
	-- Sets the "workspace" to the directory where any of these files is found.
	-- Files that share a root directory will reuse the LSP server connection.
	-- Nested lists indicate equal priority, see |vim.lsp.Config|.
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	-- Specific settings to send to the server. The schema is server-defined.
	-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			-- diagnostics = {
			-- 	globals = { 'vim' },
			-- }
		}
	}
}

vim.lsp.config['rust_analyzer'] = {
	-- Command and arguments to start the server.
	cmd = { '/Users/alickaufmann/Downloads/rust-analyzer-aarch64-apple-darwin' },

	-- Filetypes to automatically attach to.
	filetypes = { 'rs' },

	-- Root markers to identify the root directory of the workspace.
	root_markers = { 'Cargo.toml', '.git' },

	-- Specific settings to send to the server (optional).
	settings = {
		["rust_analyzer"] = {
			-- Example settings: enable/disable features in rust-analyzer
			assist = {
				importGranularity = "module", -- Defines import granularity (e.g., 'crate', 'module', etc.)
				importPrefix = "by_self", -- Prefix to use for importing (can be 'by_self' or 'none')
			},
			cargo = {
				loadOutDirsFromCheck = true, -- Ensures that the output directory is correctly loaded for builds
			},
			procMacro = {
				enable = true, -- Enables procedural macros support in Rust
			},
			diagnostics = {
				disabled = { "unresolved-proc-macro" }, -- Optionally disable specific diagnostics
				enable = true, -- Enable diagnostics
			},
			-- You can also set other settings for rust-analyzer like:
			--   - enableClippyLints
			--   - checkOnSave
			--   - rustfmt
		}
	}
}

vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/implementation')
		then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end
		if client:supports_method('textDocument/references') then
			vim.keymap.set('n', 'grr', function()
				require('fzf-lua').lsp_references()
			end, { noremap = true, silent = true, buffer = args.buf })
		end

		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if not client:supports_method('textDocument/willSaveWaitUntil')
		    and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})

vim.diagnostic.config({
	virtual_lines = ({
		current_line = true,
	}),
})
