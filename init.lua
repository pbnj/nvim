-- [[ Global Variables ]]
-- Leader key mapping must come first to prevent plugin initialization race conditions
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_tohtml_plugin = 1
vim.g.netrw_keepdir = 0

-- [[ Options ]]
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.fillchars = { vert = "│", stl = "─", stlnc = "═" }
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.shortmess = vim.opt.shortmess + "I"
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
vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  { desc = "Go to previous [D]iagnostic message" }
)
vim.keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  { desc = "Go to next [D]iagnostic message" }
)
vim.keymap.set(
  "n",
  "<leader>e",
  vim.diagnostic.open_float,
  { desc = "Show diagnostic [E]rror messages" }
)
vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostic [Q]uickfix list" }
)

-- Terminal keymaps
vim.keymap.set(
  "t",
  "<Esc><Esc>",
  "<C-\\><C-n>",
  { desc = "Exit terminal mode" }
)

-- [[ Autocommands ]]
-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup(
    "kickstart-highlight-yank",
    { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Plugin Manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
end
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
  { "tpope/vim-dadbod", event = "VeryLazy" },
  { "tpope/vim-eunuch", event = "VeryLazy" },
  { "tpope/vim-rsi", event = "VeryLazy" },
  { "tpope/vim-sleuth", event = "VeryLazy" },
  { "tpope/vim-unimpaired", event = "VeryLazy" },
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    cmd = { "G", "Gw", "Gwrite", "GB", "GBrowse" },
    keys = {
      { "<leader>gg", vim.cmd.Git, desc = "[G]it client (fugitive)" },
      {
        "<leader>gb",
        vim.cmd.GBrowse,
        desc = "[G]it [B]rowse",
        mode = { "n", "v" },
      },
      { "<leader>gw", vim.cmd.GWrite, desc = "[GW]rite (git add)" },
    },
  },

  -- to be deprecated once neovim 0.10 (built-in commenting support) is released. see https://github.com/neovim/neovim/pull/28176
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },

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
      vim.keymap.set(
        "n",
        "<leader>sh",
        builtin.help_tags,
        { desc = "[S]earch [H]elp" }
      )
      vim.keymap.set(
        "n",
        "<leader>fk",
        builtin.keymaps,
        { desc = "[F]ind [K]eymaps" }
      )
      vim.keymap.set(
        "n",
        "<leader>ff",
        builtin.find_files,
        { desc = "[F]ind [F]iles" }
      )
      vim.keymap.set(
        "n",
        "<leader>fw",
        builtin.grep_string,
        { desc = "[F]ind current [W]ord" }
      )
      vim.keymap.set(
        "n",
        "<leader>fg",
        builtin.live_grep,
        { desc = "[F]ind by [G]rep" }
      )
      vim.keymap.set(
        "n",
        "<leader>fd",
        builtin.diagnostics,
        { desc = "[F]ind [D]iagnostic" }
      )
      vim.keymap.set(
        "n",
        "<leader>fr",
        builtin.resume,
        { desc = "[F]ind [R]esume" }
      )
      vim.keymap.set(
        "n",
        "<leader>f.",
        builtin.oldfiles,
        { desc = '[F]ind Recent Files ("." for repeat)' }
      )
      vim.keymap.set(
        "n",
        "<leader>fb",
        builtin.buffers,
        { desc = "[F]ind existing [B]uffers" }
      )
      vim.keymap.set("n", "<leader>fe", function()
        telescope.extensions.file_browser.file_browser()
      end, { desc = "[F]ile [E]xplorer" })
    end,
  },

  -- Formatters
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
      },
      formatters_by_ft = {
        go = { { "goimports", "gofmt" } },
        javascript = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        lua = { "stylua" },
        markdown = { { "prettierd", "prettier" }, "doctoc --no-title" },
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
      vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWritePost", "InsertLeave" },
        {
          group = lint_augroup,
          callback = function()
            require("lint").try_lint()
          end,
        }
      )
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
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "andersevenrud/cmp-tmux",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})
      cmp.setup({
        -- completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
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
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- mason
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "actionlint",
          "doctoc",
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
        },
      })
    end,
  },
  -- {import = 'custom.plugins'}
})

-- [[ Filetypes ]]
vim.filetype.add({
  filename = {
    [".snyk"] = "yaml",
  },
})
