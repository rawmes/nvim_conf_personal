return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "saghen/blink.cmp" },
		{ "mason-org/mason.nvim" },
		{ "mason-org/mason-lspconfig.nvim" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- All LSP servers
		local lsp_servers = {
			-- Core
			"lua_ls",
			"bashls",
			"pylsp",
			"jsonls",
			"clangd",

			-- Web
			"ts_ls",
			"eslint",
			"html",
			"cssls",
			"emmet_ls",
		}

		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = lsp_servers,
			handlers = {
				-- Default handler
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- Lua
				lua_ls = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								telemetry = { enable = false },
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									checkThirdParty = false,
								},
							},
						},
						on_init = function(client)
							local join = vim.fs.joinpath
							local runtime_path = vim.split(package.path, ";")

							table.insert(runtime_path, join("lua", "?.lua"))
							table.insert(
								runtime_path,
								join("lua", "?", "init.lua")
							)

							client.config.settings.Lua.runtime = {
								version = "LuaJIT",
								path = runtime_path,
							}

							client.config.settings.Lua.workspace.library = {
								vim.env.VIMRUNTIME,
								vim.fn.stdpath("config"),
							}
						end,
					})
				end,

				-- ESLint
				eslint = function()
					lspconfig.eslint.setup({
						capabilities = capabilities,
						on_attach = function(_, bufnr)
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								command = "EslintFixAll",
							})
						end,
					})
				end,

				-- HTML
				html = function()
					lspconfig.html.setup({
						capabilities = capabilities,
					})
				end,

				-- CSS
				cssls = function()
					lspconfig.cssls.setup({
						capabilities = capabilities,
					})
				end,

				-- Emmet
				emmet_ls = function()
					lspconfig.emmet_ls.setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
						},
					})
				end,

				-- Python
				pylsp = function()
					lspconfig.pylsp.setup({
						capabilities = capabilities,
					})
				end,

				-- C / C++
				clangd = function()
					lspconfig.clangd.setup({
						capabilities = capabilities,
						cmd = {
							"clangd",
							"--background-index",
							"--clang-tidy",
							"--log=verbose",
						},
						filetypes = { "c", "cpp", "objc", "objcpp" },
						root_dir = lspconfig.util.root_pattern(
							"compile_commands.json",
							"compile_flags.txt",
							".git"
						),
						init_options = {
							fallbackFlags = { "-std=c++17" },
						},
					})
				end,
			},
		})

		-- Godot
		lspconfig.gdscript.setup({
			capabilities = capabilities,
		})
	end,

	cmd = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "x" }, "<F3>", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
				vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
			end,
		})

		return { "LspInfo", "LspInstall", "LspStart" }
	end,
}
