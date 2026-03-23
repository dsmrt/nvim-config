return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters = {
      biome = {
        -- Only use biome when biome.json is present in the project
        condition = function(self, ctx)
          return vim.fs.find({ "biome.json", "biome.jsonc" }, {
            path = ctx.dirname,
            upward = true,
          })[1] ~= nil
        end,
      },
      vp_fmt = {
        -- Use the project-local vp binary if available
        command = function(self, ctx)
          local vp = vim.fs.find("node_modules/.bin/vp", {
            upward = true,
            path = ctx.dirname,
            type = "file",
          })[1]
          return vp or "vp"
        end,
        args = { "fmt", "--stdin-filepath", "$FILENAME" },
        stdin = true,
        cwd = function(self, ctx)
          local root = vim.fs.find("package.json", {
            upward = true,
            path = ctx.dirname,
          })[1]
          return root and vim.fn.fnamemodify(root, ":h") or ctx.dirname
        end,
      },
    },
    formatters_by_ft = {
      php = { "php_cs_fixer" },
      javascript = { "biome", "vp_fmt", stop_after_first = true },
      typescript = { "biome", "vp_fmt", stop_after_first = true },
      javascriptreact = { "biome", "vp_fmt", stop_after_first = true },
      typescriptreact = { "biome", "vp_fmt", stop_after_first = true },
      json = { "biome", "vp_fmt", stop_after_first = true },
      jsonc = { "biome", "vp_fmt", stop_after_first = true },
    },
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
  },
}
