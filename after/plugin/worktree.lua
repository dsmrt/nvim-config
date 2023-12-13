require("telescope").load_extension("git_worktree")

vim.keymap.set("n", "<leader>gt", function ()
    require('telescope').extensions.git_worktree.git_worktrees()
end)

