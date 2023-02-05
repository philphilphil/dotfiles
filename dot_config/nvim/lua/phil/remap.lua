vim.g.mapleader = " "
vim.keymap.set("n", "<Esc>", ":w<CR>")

-- move lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- join lines
vim.keymap.set("n", "J", "mzJ`z")

-- keep center when goign up/down half pges
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- same but for search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- go to next/prev error
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- bufferline
vim.keymap.set("n", "<S-h>", "<cmd>BufferPrevious<CR>")
vim.keymap.set("n", "<S-l>", "<cmd>BufferNext<CR>")

-- do most keymaps in whichkey for nice documentation
local wk = require("which-key")
wk.register({
  s = {
    name = "Search", -- optional group name
    g = { "<cmd>Telescope live_grep<cr>", "Grep Files" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    f = { "<cmd>Telescope find_files<cr>", "All Files" },
    c = { "<cmd>Telescope commands<cr>", "Vim Commands" },
  },
  g = {
      name = "Code",
      a = { function() vim.lsp.buf.code_action() end, "Code Action" },
      n = { function() vim.lsp.buf.rename() end, "Rename" },
      f = { function() vim.lsp.buf.format() end, "Format" },
      r = { "<cmd>Telescope lsp_references<cr>", "References" },
  },
  -- more telescope things
  f = { "<cmd>Telescope git_files<cr>", "Find Git File" },
  x = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "LSP Diagnostics" },
  t = { "<cmd>TODOTelescope<CR>", "Todos" },

  -- bffer navigation
  ["1"] = { "<cmd>BufferGoto 1<CR>", "which_key_ignore" },
  ["2"] = { "<cmd>BufferGoto 2<CR>", "which_key_ignore" },
  ["3"]= { "<cmd>BufferGoto 3<CR>", "which_key_ignore" },
  ["4"]= { "<cmd>BufferGoto 4<CR>", "which_key_ignore" },
  ["5"]= { "<cmd>BufferGoto 5<CR>", "which_key_ignore" },
  ["6"]= { "<cmd>BufferGoto 6<CR>", "which_key_ignore" },
  ["7"]= { "<cmd>BufferGoto 7<CR>", "which_key_ignore" },
  ["0"]= { "<cmd>BufferPin<CR>", "Pin Buffer" },
  w = { "<cmd>BufferClose<CR>", "Close Buffer" },

  -- paste and delete withount yanking
  p = { [["_dP]], "Paste w/o y" },
  d = { [["_d]], "Del w/o y" },

  -- other features
  u = { "<cmd>UndotreeToggle<CR>", "Undotree" },
  e = { "<cmd>NvimTreeToggle<CR>", "File Tree" },

  -- start replace for word under courser
  ["S"]= { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Substitute" }
}, { prefix = "<leader>" })


-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
-- vim.keymap.set('n', '<leader>ft', "<cmd>TODOTelescope<CR>")
