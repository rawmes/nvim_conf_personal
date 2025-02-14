return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "saghen/blink.cmp" },
		-- { "hrsh7th/cmp-nvim-lsp" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- lsp_defaults.capabilities = vim.tbl_deep_extend(
		-- 	"force",
		-- 	lsp_defaults.capabilities,
		-- 	require("cmp_nvim_lsp").default_capabilities()
		-- )

		local lsp_servers = {
			"lua_ls",
			"bashls",
			"pylsp",
			"jsonls",
		}
		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = lsp_servers,
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				lua_ls = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								telemetry = {
									enable = false,
								},
							},
						},
						on_init = function(client)
							local join = vim.fs.joinpath
							local lazy_plugin_path = "~/.local/share/nvim/lazy/"

							local runtime_path = vim.split(package.path, ";")
							table.insert(runtime_path, join("lua", "?.lua"))
							table.insert(
								runtime_path,
								join("lua", "?", "init.lua")
							)

							local nvim_settings = {
								runtime = {
									version = "LuaJIT",
									path = runtime_path,
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
										vim.fn.stdpath("config"),
										join(
											lazy_plugin_path,
											"LazyVim",
											"init.lua"
										),
									},
								},
							}

							client.config.settings.Lua = vim.tbl_deep_extend(
								"force",
								client.config.settings.Lua,
								nvim_settings
							)
						end,
					})
				end,
				eslint = function()
					require("lspconfig").eslint.setup({
						on_attach = function(client, bufnr)
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								command = "EslintFixAll",
							})
						end,
					})
				end,
				pylsp = function()
					require("lspconfig").pylsp.setup({})
				end,
				clangd = function()
					require("lspconfig").clangd.setup({
						cmd = {
							"clangd",
							"--background-index",
							"--clang-tidy",
							"--log=verbose",
						},
						init_options = {
							fallbackFlags = { "-std=c++17" },
						},
					})
				end,
			},
		})
		require("lspconfig").gdscript.setup({})
	end,
	cmd = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set(
					"n",
					"K",
					"<cmd>lua vim.lsp.buf.hover()<cr>",
					opts
				)
				vim.keymap.set(
					"n",
					"gd",
					"<cmd>lua vim.lsp.buf.definition()<cr>",
					opts
				)
				vim.keymap.set(
					"n",
					"gD",
					"<cmd>lua vim.lsp.buf.declaration()<cr>",
					opts
				)
				vim.keymap.set(
					"n",
					"gi",
					"<cmd>lua vim.lsp.buf.implementation()<cr>",
					opts
				)
				vim.keymap.set(
					"n",
					"go",
					"<cmd>lua vim.lsp.buf.type_definition()<cr>",
					opts
				)
				vim.keymap.set(
					"n",
					"gr",
					"<cmd>lua vim.lsp.buf.references()<cr>",
					opts
				)
				vim.keymap.set(
					"n",
					"gs",
					"<cmd>lua vim.lsp.buf.signature_help()<cr>",
					opts
				)
				vim.keymap.set(
					"n",
					"<F2>",
					"<cmd>lua vim.lsp.buf.rename()<cr>",
					opts
				)
				vim.keymap.set(
					{ "n", "x" },
					"<F3>",
					"<cmd>lua vim.lsp.buf.format({async = true})<cr>",
					opts
				)
				vim.keymap.set(
					"n",
					"<F4>",
					"<cmd>lua vim.lsp.buf.code_action()<cr>",
					opts
				)
			end,
		})
		return { "LspInfo", "LspInstall", "LspStart" }
	end,
}
