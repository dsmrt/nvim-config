require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

require("mason").setup()
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

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("biome", {
  root_markers = { "biome.json", "biome.jsonc" },
})
vim.lsp.config("phpactor", {
  cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/phpactor"), "language-server" },
  root_markers = { "composer.json", ".git", ".phpactor.json", ".phpactor.yml" },
  filetypes = { "php" },
})
vim.lsp.config("pyright", {
  settings = {
    pyright = { disableOrganizeImports = true },
    python = { analysis = { ignore = { "*" } } },
  },
})
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = { diagnostics = { enable = false } },
  },
})
vim.lsp.config("vtsls", {
  root_markers = { ".git" },
  settings = {
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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gra", vim.lsp.buf.code_action, opts)

    if client:supports_method("textDocument/formatting") then
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
      local conform_filetypes = {
        "javascript", "typescript", "javascriptreact", "typescriptreact",
        "json", "jsonc", "php",
      }
      if not vim.tbl_contains(conform_filetypes, filetype) then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end
  end,
})
