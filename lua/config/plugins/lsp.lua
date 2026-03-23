return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.lsp.config("bashls", { capabilities = capabilities })
      vim.lsp.config("biome", {
        capabilities = capabilities,
        -- Only attach when biome.json is present in the project
        root_markers = { "biome.json", "biome.jsonc" },
      })
      vim.lsp.config("gopls", { capabilities = capabilities })
      vim.lsp.config("lua_ls", { capabilities = capabilities })
      vim.lsp.config("phpactor", {
        capabilities = capabilities,
        cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/phpactor"), "language-server" },
        root_markers = { "composer.json", ".git", ".phpactor.json", ".phpactor.yml" },
        filetypes = { "php" },
      })
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          pyright = {
            disableOrganizeImports = true, -- Ruff handles imports
          },
          python = {
            analysis = {
              ignore = { '*' }, -- Ruff handles linting
            },
          },
        },
      })
      vim.lsp.config("ruff", { capabilities = capabilities })
      vim.lsp.config("rust_analyzer", {
        settings = {
          ['rust-analyzer'] = {
            diagnostics = { enable = false },
          },
        },
      })
      vim.lsp.config("terraformls", { capabilities = capabilities })
      vim.lsp.config("vtsls", {
        capabilities = capabilities,
        root_markers = { '.git' },
        settings = {
          -- Formatting handled by conform
          javascript = { format = { enable = false } },
          typescript = { format = { enable = false } },
        },
      })

      vim.lsp.enable({
        "bashls",
        "biome",
        "gopls",
        "lua_ls",
        "phpactor",
        "pyright",
        "ruff",
        "rust_analyzer",
        "tailwindcss",
        "terraformls",
        "vtsls",
      })

      require("mason").setup {}
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "biome",
          "lua_ls",
          "phpactor",
          "ruff",
          "rust_analyzer",
          "terraformls",
          "vtsls",
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, opts)

          if client:supports_method('textDocument/formatting') then
            local filetype = vim.api.nvim_get_option_value('filetype', { buf = args.buf })
            -- These filetypes are handled by conform.nvim
            local conform_filetypes = {
              'javascript', 'typescript', 'javascriptreact', 'typescriptreact',
              'json', 'jsonc', 'php',
            }
            if not vim.tbl_contains(conform_filetypes, filetype) then
              vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                  vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
              })
            end
          end
        end,
      })
    end,
  }
}
