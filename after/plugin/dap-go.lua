local dap = require('dap')
local dapgo = require('dap-go')
local dapui = require('dapui')

-- Setup dap-go
dapgo.setup()

-- Configure nvim-dap to attach to Delve
dap.adapters.go = {
    type = 'server',
    host = '127.0.0.1',
    port = '2343',
}

dap.configurations.go = {
    {
        type = "go",
        name = "Devspace",
        request = "attach",
        mode = "remote",
        substitutePath = {
            {
                from = "${workspaceFolder}",
                to = "/workspace",
            },
        },
        showLog = true,
    },
}

-- Setup nvim-dap-ui
dapui.setup()

-- Automatically open/close dap-ui when debugging starts/ends
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Keybindings for nvim-dap
vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })


vim.api.nvim_set_keymap('n', '<F7>', '<Cmd>lua require\'dap\'.step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F8>', '<Cmd>lua require\'dap\'.step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F9>', '<Cmd>lua require\'dap\'.step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require\'dap\'.continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require\'dap\'.terminate()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', '<Cmd>lua require\'dap\'.toggle_breakpoint()<CR>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>B', '<Cmd>lua require\'dap\'.clear_breakpoints()<CR>',
    { noremap = true, silent = true })
vim.keymap.set('n', '<leader>D', function() -- debug go test
    require('dap-go').debug_test();
end)
