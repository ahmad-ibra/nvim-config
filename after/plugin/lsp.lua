require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
})

local lsp = require("lsp-zero")

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
            for _, client in pairs(clients) do
                if client.supports_method("textDocument/formatting") then
                    vim.lsp.buf.format({ bufnr = bufnr })
                    return
                end
            end
        end,
    })
end)

vim.filetype.add({ extension = { templ = "templ" } })

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = ''
    }
})

local icons = {
    [vim.diagnostic.severity.ERROR] = "✘",
    [vim.diagnostic.severity.WARN]  = "▲",
    [vim.diagnostic.severity.INFO]  = "",
    [vim.diagnostic.severity.HINT]  = "⚑",
}

vim.diagnostic.config({
    virtual_text = {
        prefix = function(diagnostic)
            return icons[diagnostic.severity] or ""
        end,
        format = function(diagnostic)
            return diagnostic.message
        end,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons[vim.diagnostic.severity.ERROR],
            [vim.diagnostic.severity.WARN]  = icons[vim.diagnostic.severity.WARN],
            [vim.diagnostic.severity.INFO]  = icons[vim.diagnostic.severity.INFO],
            [vim.diagnostic.severity.HINT]  = icons[vim.diagnostic.severity.HINT],
        }
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
