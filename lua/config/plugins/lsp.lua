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
      -- local lspconfig = require("lspconfig")
      vim.lsp.config("bashls", { capabilities = capabilities })
      vim.lsp.config("biome", {
        root_markers = { '.git' },
        capabilities = capabilities,
        -- settings = {
        --   typescript = {
        --     format = {
        --       enable = true
        --     }
        --   }
        -- }
      })
      vim.lsp.config("gopls", { capabilities = capabilities })
      vim.lsp.config("lua_ls", { capabilities = capabilities })
      vim.lsp.config("phpactor", { capabilities = capabilities })
      vim.lsp.config("ruff", { capabilities = capabilities })
      -- vim.lsp.config("tailwindcss", { capabilities = capabilities })
      vim.lsp.config("rust_analyzer", {
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = false,
            }
          }
        }
      })
      vim.lsp.config("terraformls", { capabilities = capabilities })
      vim.lsp.config("vtsls", {
        root_markers = { '.git' },
        capabilities = capabilities,
        settings = {
          javascript = {
            format = {
              enable = false
            }
          },
          typescript = {
            format = {
              enable = false
            }
          }
        }
      })
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { '*' },
            },
          },
        }
      })
      -- vim.lsp.config({
      --   gopls = { capabilities = capabilities },
      -- "lua_ls = { capabilities = capabilities },
      -- "vtsls = { capabilities = capabilities },
      -- "rust_analyzer = {
      --   settings = {
      --     ['rust-analyzer'] = {
      --       diagnostics = {
      --         enable = false,
      --       }
      --     }
      --   }
      -- },
      -- bashls = { capabilities = capabilities },
      -- biome = { capabilities = capabilities },
      -- terraformls = { capabilities = capabilities },
      -- phpactor = { capabilities = capabilities },
      -- })

      vim.lsp.enable({
        "bashls",
        "biome",
        "gopls",
        "lua_ls",
        "phpactor",
        "pyright",
        "ruff",
        "rust_analyzer",
        "terraformls",
        "tailwindcss",
        -- "vtsls",
      }, true)
      -- lspconfig.gopls.setup { capabilities = capabilities }
      -- lspconfig.golangci_lint_ls.setup { capabilities = capabilities }
      -- lspconfig.lua_ls.setup { capabilites = capabilities }
      -- use this or tstools
      -- lspconfig.ts_ls.setup { capabilites = capabilities }
      -- lspconfig.ruff.setup { capabilites = capabilities }
      -- lspconfig.vtsls.setup { capabilites = capabilities }
      -- lspconfig.rust_analyzer.setup {
      --   settings = {
      --     ['rust-analyzer'] = {
      --       diagnostics = {
      --         enable = false,
      --       }
      --     }
      --   }
      -- }

      -- npm i -g bash-language-server
      -- lspconfig.bashls.setup { capabilites = capabilities }

      -- npm install [-g] @biomejs/biome
      -- lspconfig.biome.setup { capabilites = capabilities }

      -- npm i -g vscode-langservers-extracted
      -- lspconfig.jsonls.setup { capabilities = capabilities }
      -- lspconfig.terraformls.setup { capabilities = capabilities }
      -- lspconfig.phpactor.setup { capabilities = capabilities }

      require("mason").setup {}
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "vtsls",
          -- "ts_ls",
          "ruff",
          "bashls",
          "biome",
          "terraformls",
          "rust_analyzer",
          "phpactor"
        }
      })


      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          -- vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
          -- vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
          -- vim.keymap.set('n', 'grr', vim.lsp.buf.references)
          -- vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
          -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true })
          -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
          -- if client:supports_method('textDocument/implementation') then
          --   -- Create a keymap for vim.lsp.buf.implementation ...
          -- end
          --
          -- -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
          -- if client:supports_method('textDocument/completion') then
          --   -- Optional: trigger autocompletion on EVERY keypress. May be slow!
          --   -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
          --   -- client.server_capabilities.completionProvider.triggerCharacters = chars
          --
          --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
          -- end

          -- Auto-format ("lint") on save.
          -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
          -- if client:supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
            end,
          })
          -- end
        end,
      })
      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     local c = vim.lsp.get_client_by_id(args.data.client_id)
      --     if not c then return end
      --
      --     vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
      --     vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
      --     vim.keymap.set('n', 'grr', vim.lsp.buf.references)
      --     vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
      --     vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true })
      --     vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
      --
      --     -- Format the current buffer on save
      --     vim.api.nvim_create_autocmd('BufWritePre', {
      --       buffer = args.buf,
      --       callback = function()
      --         vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
      --       end,
      --     })
      --   end,
      -- })
    end,
  }
}
