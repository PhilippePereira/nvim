local keymap = vim.keymap.set
local silent = { silent = true }

-- Better window movement
keymap("n", "<C-h>", "<C-w>h", silent)
keymap("n", "<C-j>", "<C-w>j", silent)
keymap("n", "<C-k>", "<C-w>k", silent)
keymap("n", "<C-l>", "<C-w>l", silent)

-- H to move to the first non-blank character of the line
keymap("n", "H", "^", silent)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", silent)
keymap("x", "J", ":move '>+1<CR>gv-gv", silent)

-- Keep visual mode indenting
keymap("v", "<", "<gv", silent)
keymap("v", ">", ">gv", silent)

-- Save file by CTRL-S
keymap("n", "<S-s>", ":w<CR>", silent)
keymap("i", "<S-s>", "<ESC> :w<CR>", silent)

-- Remove highlights
keymap("n", "<CR>", ":noh<CR><CR>", silent)

-- Buffers
keymap("n", "<Tab>", ":BufferNext<CR>", silent)
keymap("n", "<S-Tab>", ":BufferPrevious<CR>", silent)
keymap("n", "<S-q>", ":BufferClose<CR>", silent)

-- Move between barbar buffers
keymap("n", "<Space>1", ":BufferGoto 1<CR>", silent)
keymap("n", "<Space>2", ":BufferGoto 2<CR>", silent)
keymap("n", "<Space>3", ":BufferGoto 3<CR>", silent)
keymap("n", "<Space>4", ":BufferGoto 4<CR>", silent)
keymap("n", "<Space>5", ":BufferGoto 5<CR>", silent)
keymap("n", "<Space>6", ":BufferGoto 6<CR>", silent)
keymap("n", "<Space>7", ":BufferGoto 7<CR>", silent)
keymap("n", "<Space>8", ":BufferGoto 8<CR>", silent)
keymap("n", "<Space>9", ":BufferGoto 9<CR>", silent)

-- Don't yank on delete char
keymap("n", "x", '"_x', silent)
keymap("n", "X", '"_X', silent)
keymap("v", "x", '"_x', silent)
keymap("v", "X", '"_X', silent)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', silent)

-- LSP
-- keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silent) -- Replaced with Glance plugin
-- keymap("n", "gr", "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", silent) -- Replaced with Glance plugin
-- keymap("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
-- keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
-- keymap("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.code_action()<CR>", silent)
-- keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", silent)
-- keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", silent)
-- keymap("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", silent)
-- keymap("n", "<leader>cl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
-- keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
-- keymap("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent)
-- keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
-- keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
-- keymap("n", "K", function()
--   local winid = require('ufo').peekFoldedLinesUnderCursor()
--   if not winid then
--     vim.lsp.buf.hover()
--   end
-- end)

-- Comment Box
keymap("n", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", silent)
keymap("v", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", silent)
