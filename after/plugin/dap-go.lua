local dap = require('dap')
local dapgo = require('dap-go')
local dapui = require('dapui')
local fzf = require('fzf-lua')

-- Setup dap-go and dap-ui
dapgo.setup()
dapui.setup()

-- Disable automatic loading of launch.json
vim.g.dap_virtual_text = true

-- Automatically open/close dap-ui when debugging starts/ends
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

local function find_nearest_dap_config(start_dir)
    local Path = vim.fn.fnamemodify
    local dir = start_dir

    while dir ~= "/" do
        local dap_path = dir .. "/.nvim/dap.lua"
        if vim.fn.filereadable(dap_path) == 1 then
            return dap_path
        end
        dir = Path(dir, ":h")
    end

    return nil
end

-- Load project-specific .nvim/dap.lua if it exists
local function load_project_dap_config()
    local cwd = vim.fn.getcwd()
    local dap_config_file = find_nearest_dap_config(cwd)
    if dap_config_file then
        local ok, err = pcall(dofile, dap_config_file)
        if not ok then
            vim.notify("Error loading " .. dap_config_file .. ":\n" .. err, vim.log.levels.ERROR)
        end
    else
        -- fallback adapter or config can go here
    end
end

load_project_dap_config()

-- DAP configuration picker using fzf-lua
local function select_config()
    local configs = dap.configurations.go or {}

    -- Extract just the names of the configurations
    local config_names = vim.tbl_map(function(config)
        return config.name
    end, configs)

    fzf.fzf_exec(config_names, {
        prompt = "Select DAP Config: ",
        actions = {
            ["default"] = function(selected)
                local config_name = selected[1]
                for _, config in ipairs(configs) do
                    if config.name == config_name then
                        dap.run(config)
                        break
                    end
                end
            end,
        },
    })
end

-- Create a user command to select a config via fzf
vim.api.nvim_create_user_command("SelectDAPConfig", function()
    select_config()
end, {})

-- Map a key to select a config with fzf
vim.api.nvim_set_keymap('n', '<leader>dc', ':SelectDAPConfig<CR>', { noremap = true, silent = true })

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
