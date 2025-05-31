-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps
keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })
keymap.set("n", "<leader>qq", ":q!<CR>", { desc = "Quit without saving" })
keymap.set("n", "<leader>ww", ":w<CR>", { desc = "Save" })
keymap.set("n", "gx", ":!open <c-r><c-a><CR>", { desc = "Open URL under cursor" })

-- Toggle terminal
keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true, desc = "Toggle terminal" })

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close split window" })
keymap.set("n", "<leader>sj", "<C-w>-", { desc = "Make split window height shorter" })
keymap.set("n", "<leader>sk", "<C-w>+", { desc = "Make split window height taller" })
keymap.set("n", "<leader>sl", "<C-w>>5", { desc = "Make split window width bigger" })
keymap.set("n", "<leader>sh", "<C-w><5", { desc = "Make split window width smaller" })

-- Tab management
-- keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open a new tab" })
-- keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close a tab" })
-- keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
-- keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>", { desc = "Put diff from current to other during diff" })
keymap.set("n", "<leader>cj", ":diffget 1<CR>", { desc = "Get diff from left (local) during merge" })
keymap.set("n", "<leader>ck", ":diffget 3<CR>", { desc = "Get diff from right (remote) during merge" })
keymap.set("n", "<leader>cn", "]c", { desc = "Next diff hunk" })
keymap.set("n", "<leader>cp", "[c", { desc = "Previous diff hunk" })

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
keymap.set("n", "<leader>qf", ":cfirst<CR>", { desc = "Jump to first quickfix list item" })
keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "Jump to next quickfix list item" })
keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = "Jump to previous quickfix list item" })
keymap.set("n", "<leader>ql", ":clast<CR>", { desc = "Jump to last quickfix list item" })
keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })

-- Buffers
keymap.set("n", "<leader>bq", ":bd<CR>", { desc = "Delete buffer" })

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Toggle maximize tab" })

-- Nvim-tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>", { desc = "Focus on file explorer" })
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = "Find file in file explorer" })

-- Telescope
keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Fuzzy find files in project" })
keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Grep file contents in project" })
keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Fuzzy find open buffers" })
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "Fuzzy find help tags" })
keymap.set('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find, { desc = "Fuzzy find in current file buffer" })
keymap.set('n', '<leader>fo', require('telescope.builtin').lsp_document_symbols, { desc = "Fuzzy find LSP/class symbols" })
keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, { desc = "Fuzzy find LSP/incoming calls" })
keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({ symbols = { 'function', 'method' } }) end, { desc = "Fuzzy find methods in current class" })
keymap.set('n', '<leader>ft', function() -- grep file contents in current nvim-tree node
    local success, node = pcall(function() return require('nvim-tree.lib').get_node_at_cursor() end)
    if not success or not node then return end;
    require('telescope.builtin').live_grep({ search_dirs = { node.absolute_path } })
end, { desc = "Grep file contents in current nvim-tree node" })

-- Git-blame
keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", { desc = "Toggle git blame" })

-- Harpoon
keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Add file to Harpoon" })
keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu, { desc = "Toggle Harpoon quick menu" })
keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end, { desc = "Navigate to Harpoon file 1" })
keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end, { desc = "Navigate to Harpoon file 2" })
keymap.set("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end, { desc = "Navigate to Harpoon file 3" })
keymap.set("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end, { desc = "Navigate to Harpoon file 4" })
keymap.set("n", "<leader>h5", function() require("harpoon.ui").nav_file(5) end, { desc = "Navigate to Harpoon file 5" })
keymap.set("n", "<leader>h6", function() require("harpoon.ui").nav_file(6) end, { desc = "Navigate to Harpoon file 6" })
keymap.set("n", "<leader>h7", function() require("harpoon.ui").nav_file(7) end, { desc = "Navigate to Harpoon file 7" })
keymap.set("n", "<leader>h8", function() require("harpoon.ui").nav_file(8) end, { desc = "Navigate to Harpoon file 8" })
keymap.set("n", "<leader>h9", function() require("harpoon.ui").nav_file(9) end, { desc = "Navigate to Harpoon file 9" })

-- Vim REST Console
keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>", { desc = "Run REST query" })

-- LSP
keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "Hover documentation" })
keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "Go to definition" })
keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "Go to declaration" })
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "Go to implementation" })
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "Go to type definition" })
keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = "Find references" })
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Signature help" })
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "Rename symbol" })
keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "Format buffer" })
keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "Format buffer" })
keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "Code action" })
keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Open diagnostic float" })
keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = "Go to previous diagnostic" })
keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = "Go to next diagnostic" })
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', { desc = "Document symbols" })
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>', { desc = "Trigger completion" })

-- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { desc = "Set conditional breakpoint" })
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", { desc = "Set log point" })
keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>", { desc = "Clear breakpoints" })
keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', { desc = "List breakpoints" })
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "Continue debugging" })
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Step over" })
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Step into" })
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", { desc = "Step out" })
keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end, { desc = "Disconnect and close DAP UI" })
keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end, { desc = "Terminate and close DAP UI" })
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "Toggle REPL" })
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { desc = "Run last debug session" })
keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end, { desc = "Hover debug info" })
keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end, { desc = "Show scopes" })
keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>', { desc = "List frames" })
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>', { desc = "List DAP commands" })
keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({ default_text = ":E:" }) end, { desc = "List diagnostics" })
