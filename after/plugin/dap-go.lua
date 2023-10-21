require("dap-go").setup()

vim.keymap.set('n', '<leader>dgt', function() -- debug go test
    require('dap-go').debug_test();
end)

vim.keymap.set('n', '<leader>db', require 'dap'.toggle_breakpoint)
vim.keymap.set('n', '<F7>', require 'dap'.step_over)
vim.keymap.set('n', '<F8>', require 'dap'.step_into)
vim.keymap.set('n', '<F9>', require 'dap'.step_out)
vim.keymap.set('n', '<F10>', require 'dap'.continue)

-- make breakpoints look nicer
vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

-- make debugging interface nice
require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
