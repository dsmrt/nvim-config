local parsers = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  pattern = parsers,
  callback = function(args)
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > 100 * 1024 then
      return
    end
    vim.treesitter.start()
  end,
})
