local dap = require('dap')
local dapgo = require('dap-go')
local dapui = require('dapui')

-- Setup dap-go and dap-ui
dapgo.setup()
dapui.setup()

-- Automatically open/close dap-ui when debugging starts/ends
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

local function find_nearest_dap_config(start_dir)
    local Path = vim.fn.fnamemodify
    local uv = vim.loop
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

-- DAP configuration picker
vim.api.nvim_create_user_command("Debug", function()
    vim.defer_fn(function()
        local configs = require('dap').configurations.go or {}
        if vim.tbl_isempty(configs) then
            vim.notify("No DAP configurations found for Go", vim.log.levels.WARN)
            return
        end

        local names = vim.tbl_map(function(cfg) return cfg.name or "Unnamed config" end, configs)

        vim.ui.select(names, { prompt = "Select DAP Configuration" }, function(choice)
            if not choice then return end
            for _, cfg in ipairs(configs) do
                if cfg.name == choice then
                    require('dap').run(cfg)
                    break
                end
            end
        end)
    end, 100)
end, {})

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
