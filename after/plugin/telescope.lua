local builtin = require('telescope.builtin')
vim.api.nvim_set_keymap('n', '<Leader>ff', ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
    { noremap = true, silent = true })
vim.keymap.set('n', '<C-f>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
