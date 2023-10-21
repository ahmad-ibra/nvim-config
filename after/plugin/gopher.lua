require("gopher").setup()

vim.keymap.set("n", "<leader>err", ":GoIfErr<CR>")
vim.keymap.set("n", "<leader>stj", ":GoTagAdd json<CR>")
vim.keymap.set("n", "<leader>sty", ":GoTagAdd yaml<CR>")
vim.keymap.set("n", "<leader>stx", ":GoTagAdd xml<CR>")
