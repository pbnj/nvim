-- [[ Global Variables ]]
-- Leader key mapping must come first to prevent plugin initialization race conditions
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if a Nerd Font is installed
vim.g.have_nerd_font = false

-- [[ Options ]]
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wrap = false

if vim.fn.executable("rg") then
	vim.opt.grepprg = "rg --vimgrep --smart-case $*"
end

-- [[ Keymaps ]]
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Terminal keymaps
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- [[ Autocommands ]]
-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Plugin Manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require("lazy").setup({
	-- prevent nested neovim instances
	{ "willothy/flatten.nvim", opts = {}, lazy = false, priority = 1001 },
	-- integrated terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			[[<c-\>]],
			desc = "Toggle terminal",
		},
		opts = { open_mapping = [[<c-\>]] },
	},
	-- tpope
	{ "tpope/vim-dadbod", event = "VeryLazy", dependencies = { "kristijanhusak/vim-dadbod-ui" } },
	{ "tpope/vim-dotenv", event = "VeryLazy" },
	{ "tpope/vim-eunuch", event = "VeryLazy" },
	{
		"tpope/vim-fugitive",
		dependencies = { "tpope/vim-rhubarb" },
		cmd = { "G", "Gw", "Gwrite", "GB", "GBrowse" },
		keys = {
			{ "<leader>gg", vim.cmd.Git, desc = "[G]it client (fugitive)" },
			{ "<leader>gb", vim.cmd.GBrowse, desc = "[G]it [B]rowse", mode = { "n", "v" } },
			{ "<leader>gw", vim.cmd.GWrite, desc = "[GW]rite (git add)" },
		},
	},
	{ "tpope/vim-rsi", event = "VeryLazy" },
	{ "tpope/vim-sleuth", event = "VeryLazy" },

	-- git integration
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- better gx
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
		submodules = false,
		config = function()
			require("gx").setup({
				handlers = {
					plugin = true,
					github = true,
					package_json = true,
					search = true,
					jira = {
						name = "jira",
						handle = function(mode, line, _)
							local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
							if ticket and #ticket < 20 then
								return vim.env.JIRA_URL .. "/browse/" .. ticket
							end
						end,
					},
					rust = {
						name = "rust",
						filetype = { "toml" },
						filename = "Cargo.toml",
						handle = function(mode, line, _)
							local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")
							if crate then
								return "https://crates.io/crates/" .. crate
							end
						end,
					},
				},
				handler_options = {
					search_engine = "duckduckgo",
					select_for_search = "false",
				},
			})
		end,
	},
	-- to be deprecated once neovim 0.10 (built-in commenting support) is released. see https://github.com/neovim/neovim/pull/28176
	{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },

	-- keymap hinting
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("which-key").setup()
			-- Document existing key chains
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			})
		end,
	},

	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					file_browser = {
						grouped = true,
						hidden = true,
						hide_parent_dir = true,
						hijack_netrw = true,
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
				defaults = {
					file_ignore_patterns = { ".git/" },
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"-uu",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})
			local telescope = require("telescope")
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "ui-select")
			pcall(telescope.load_extension, "file_browser")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ previewer = false }))
			end, { desc = "[/] Fuzzily search in current buffer" })
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
			vim.keymap.set("n", "<leader>fb", function()
				telescope.extensions.file_browser.file_browser()
			end, { desc = "[F]ile [B]rowser" })
		end,
	},

	-- LSP Configuration & Plugins
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			local servers = {
				bashls = {},
				gopls = {},
				pyright = {},
				rust_analyzer = {},
				tsserver = {},
				ruff_lsp = {},
				terraformls = {},
				helm_ls = {},
				jqls = {},
				jsonls = {},
				taplo = {},
				tflint = {},
				yamlls = {},
				snyk_ls = {
					filetypes = { "go", "python", "javascript", "typescript", "requirements", "json", "helm", "yaml" },
					init_options = {
						activateSnykCode = "true",
						activateSnykIac = "true",
						activateSnykOpenSource = "true",
						additionalParams = "--all-projects",
						enableTrustedFoldersFeature = "false",
						integrationName = "neovim",
						organization = vim.env.SNYK_ORG,
						token = vim.env.SNYK_TOKEN,
						trustedFolders = {
							"~/Projects/github.com/komodohealth/",
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
			}
			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"actionlint",
				"gh",
				"gitleaks",
				"goimports",
				"golangci-lint",
				"gotests",
				"gotestsum",
				"hadolint",
				"jq",
				"markdown-toc",
				"markdownlint",
				"prettier",
				"prettierd",
				"ruff",
				"shellcheck",
				"snyk",
				"stylua",
				"trivy",
				"trufflehog",
				"yamllint",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	-- Formatters
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "[C]ode [F]ormat",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				go = { { "goimports", "gofmt" } },
				javascript = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				lua = { "stylua" },
				markdown = { { "prettierd", "prettier" }, "markdown-toc --bullets '-'" },
				python = { "ruff" },
				sh = { "shfmt" },
				typescript = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
				terraform = { "terraform_fmt" },
			},
		},
	},

	-- Linters
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				dockerfile = { "hadolint" },
				markdown = { "markdownlint" },
				terraform = { "tflint" },
			}
			-- auto-run linters on certain vim events
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"andersevenrud/cmp-tmux",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				-- completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "tmux" },
				},
			})
		end,
	},

	-- colors
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	-- various mini plugins (e.g. surround, statusline, ...etc)
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.surround").setup()
			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},

	-- tree-sitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"awk",
				"bash",
				"c",
				"comment",
				"csv",
				"diff",
				"dockerfile",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"gotmpl",
				"gowork",
				"hcl",
				"helm",
				"html",
				"http",
				"ini",
				"javascript",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"rego",
				"requirements",
				"rust",
				"ssh_config",
				"strace",
				"terraform",
				"tmux",
				"toml",
				"tsv",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
})

-- [[ Filetypes ]]
vim.filetype.add({
	filename = {
		[".snyk"] = "yaml",
	},
})
-- vim: ts=2 sts=2 sw=2 et
