-- nvim-treesitter main branch (Neovim 0.12+ API)
require('nvim-treesitter').setup({})

-- Install parsers (async, no-op if already installed)
require('nvim-treesitter').install({
    "javascript", "typescript", "java", "go", "c", "lua", "vim"
})

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
