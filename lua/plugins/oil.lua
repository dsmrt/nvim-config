require("oil").setup({
  default_file_explorer = true,
  view_options = { show_hidden = true },
  keymaps = {
    ["<C-p>"] = false,
    ["<C-P>"] = "actions.preview",
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
