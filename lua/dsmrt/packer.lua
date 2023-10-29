vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim',
  }
  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  require("rose-pine").setup()
		  vim.cmd('colorscheme rose-pine')
	  end
  })

  use('nvim-tree/nvim-tree.lua')
  use('nvim-tree/nvim-web-devicons')

  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
      requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- use {
  --     "danymat/neogen",
  --     config = function()
  --         require('neogen').setup {
  --             languages = {
  --                 sh = {
  --                     template = {
  --                         annotation_convention = "google_bash"
  --                     }
  --                 },
  --                 php = {
  --                     template = {
  --                         annotation_convention = "phpdoc"
  --                     }
  --                 },
  --                 javascript = {
  --                     template = {
  --                         annotation_convention = "jsdoc"
  --                     }
  --                 },
  --                 typescript = {
  --                     template = {
  --                         annotation_convention = "jsdoc"
  --                     }
  --                 },
  --                 python = {
  --                     template = {
  --                         annotation_convention = "google_docstrings"
  --                     }
  --                 },
  --                 lua = {
  --                     template = {
  --                         annotation_convention = "emmylua"
  --                     }
  --                 },
  --             }
  --         }
  --     end,
  --     -- requires = "nvim-treesitter/nvim-treesitter",
  --     -- Uncomment next line if you want to follow only stable versions
  --     -- tag = "*"
  -- }

  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},         -- Required
		  {'hrsh7th/cmp-nvim-lsp'},     -- Required
		  {'hrsh7th/cmp-buffer'},       -- Optional
		  {'hrsh7th/cmp-path'},         -- Optional
		  {'saadparwaiz1/cmp_luasnip'}, -- Optional
		  {'hrsh7th/cmp-nvim-lua'},     -- Optional

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},             -- Required
		  {'rafamadriz/friendly-snippets'}, -- Optional
	  }
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}
end)

