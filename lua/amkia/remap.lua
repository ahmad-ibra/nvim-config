vim.g.mapleader = " "

vim.keymap.set("n", "<leader>hhh", ":vsplit ~/.config/nvim/hotkeys<cr>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") -- currently <C-f> is remapped to telescope to search git files
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- not yet added to hotkeys
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Navigate panes
vim.keymap.set("n", "<up>", "<C-w><up>")
vim.keymap.set("n", "<down>", "<C-w><down>")
vim.keymap.set("n", "<left>", "<C-w><left>")
vim.keymap.set("n", "<right>", "<C-w><right>")

-- Split panes
vim.keymap.set("n", "<leader><leader>v", ":vsplit<cr>")
vim.keymap.set("n", "<leader><leader>h", ":split<cr>")

-- Resize panes
vim.keymap.set("n", "<leader>-", ":vertical resize -20<cr>")
vim.keymap.set("n", "<leader>=", ":vertical resize +20<cr>")

-- Navigate buffers
vim.keymap.set("n", "<leader><Tab>", ":bnext<CR>")
vim.keymap.set("n", "<leader><Tab><Tab>", ":bprevious<CR>")

vim.keymap.set("n", "<leader>v", "viw")

-- Markdown preview
vim.keymap.set("n", "<leader>md", ":MarkdownPreviewToggle<CR>")

-- Buffer commands
vim.keymap.set("n", "<leader><right>", ":bnext<CR>")
vim.keymap.set("n", "<leader><left>", ":bprevious<CR>")
vim.keymap.set("n", "<leader><down>", ":bdelete<CR>")

-- kinesis remaps
vim.keymap.set("n", "j", "h")
vim.keymap.set("n", "k", "j")
vim.keymap.set("n", "l", "k")
vim.keymap.set("n", ";", "l")
vim.keymap.set("n", "h", ";")
