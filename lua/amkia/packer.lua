-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- themes
    use { "ellisonleao/gruvbox.nvim" }
    use { "sainnhe/gruvbox-material" }
    use { "sainnhe/everforest" }
    use { "rebelot/kanagawa.nvim" }
    use { "vv9k/bogster" }
    use { "srcery-colors/srcery-vim" }
    use { "NLKNguyen/papercolor-theme" }
    use { "ajmwagar/vim-deus" }
    use { "notpratheek/vim-luna" }
    use { "mbbill/vim-seattle" }
    use { "baskerville/bubblegum" }

    -- transparency
    use { 'tribela/vim-transparent' } -- ensure iterm2 transparency set to 10 and blur set to 15

    -- fzf
    use { 'ibhagwan/fzf-lua' }


    -- airline and bufferline
    use { "vim-airline/vim-airline" }
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function() require("bufferline").setup {} end
    }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('preservim/nerdtree')

    -- go debugger
    use('mfussenegger/nvim-dap')
    use('leoluz/nvim-dap-go')
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }

    -- go helpful keymappings
    use('olexsmir/gopher.nvim') -- will need to manually run :GoInstallDeps to get this working

    --use {
    --    'williamboman/mason.nvim',
    --    run = ":MasonUpdate" -- optional but useful
    --}
    --use 'williamboman/mason-lspconfig.nvim'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use({
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                -- add any options here
            })
        end,
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    })

    ---- Code Companion
    --use { "stevearc/dressing.nvim" }
    --use { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }
    --use {
    --    "echasnovski/mini.diff",
    --    config = function()
    --        require("mini.diff").setup({
    --            source = require("mini.diff").gen_source.none(),
    --        })
    --    end
    --}
    --use {
    --    "HakonHarnes/img-clip.nvim",
    --    opts = {
    --        filetypes = {
    --            codecompanion = {
    --                prompt_for_file_name = false,
    --                template = "[Image]($FILE_PATH)",
    --                use_absolute_path = true,
    --            },
    --        },
    --    }
    --}
    --use({
    --    "olimorris/codecompanion.nvim",
    --    config = function()
    --        require("codecompanion").setup()
    --    end,
    --    requires = {
    --        "nvim-lua/plenary.nvim",
    --        "nvim-treesitter/nvim-treesitter",
    --    }
    --})

    -- Avante
    use {
        'yetone/avante.nvim',
        branch = 'main',
        run = 'make',
        requires = {
            -- required plugins
            'nvim-treesitter/nvim-treesitter',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            'MeanderingProgrammer/render-markdown.nvim',

            -- Optional dependencies
            'hrsh7th/nvim-cmp',
            'nvim-tree/nvim-web-devicons', -- or use 'echasnovski/mini.icons'
            'HakonHarnes/img-clip.nvim',
            'zbirenbaum/copilot.lua',
            'stevearc/dressing.nvim', -- for enhanced input UI
            'folke/snacks.nvim'       -- for modern input UI
        }
    }
end)
