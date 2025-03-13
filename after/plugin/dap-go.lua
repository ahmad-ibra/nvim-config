local dap = require('dap')
local dapgo = require('dap-go')
local dapui = require('dapui')

-- Setup dap-go
dapgo.setup()

-- Function to explicitly show the DAP configuration picker
local function select_dap_configuration()
    vim.defer_fn(function()
        require('dap').continue() -- Triggers the selection menu
    end, 100)                     -- Small delay to ensure UI updates
end

-- Load project specific dap configurations
local function load_project_dap_config()
    local cwd = vim.fn.getcwd()
    local dap_config_file = cwd .. '/.nvim/dap.lua'
    if vim.fn.filereadable(dap_config_file) == 1 then
        dofile(dap_config_file)
    else
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
    end
end

load_project_dap_config()


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

-- Bind it to a command for easy manual triggering
vim.api.nvim_create_user_command("Debug", select_dap_configuration, {})

-- Keybindings for nvim-dap
vim.fn.sign_define('DapBreakpoint', { text = '⭕', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })


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
