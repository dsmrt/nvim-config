vim.pack.add({
  -- Colorscheme
  { src = "https://github.com/folke/tokyonight.nvim" },

  -- UI / utilities
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  -- Editor
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/tpope/vim-surround" },
  { src = "https://github.com/tpope/vim-fugitive" },

  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

  -- LSP
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },

  -- Completion
  { src = "https://github.com/saghen/blink.cmp",       version = vim.version.range("1") },
  { src = "https://github.com/rafamadriz/friendly-snippets" },

  -- Navigation
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/ThePrimeagen/harpoon",   version = "harpoon2" },
})

require("plugins.mini")
require("plugins.snacks")
require("plugins.which-key")
require("plugins.trouble")
require("plugins.oil")
require("plugins.conform")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.completion")
require("plugins.harpoon")
