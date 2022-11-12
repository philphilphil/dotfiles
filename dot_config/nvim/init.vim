"""""" Settings """"""
set background=dark
set completeopt=noinsert,menuone,noselect
set cursorline
set clipboard=unnamedplus
set hidden
set inccommand=split
set mouse=a
set number
set relativenumber
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu
set showcmd
set ignorecase
set signcolumn=yes
set termguicolors
set shortmess+=c
set updatetime=300
set colorcolumn=99

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2

filetype plugin indent on
syntax on

"""""" Mappings  """"""
let mapleader = "\<space>"
map <Esc><Esc> :w<CR>
nmap <leader>k :nohlsearch<CR>
nnoremap <Leader>= :vertical resize +20<CR>
nnoremap <Leader>- :vertical resize -20<CR>

" Buffer navigation
nnoremap <silent> gb :BufferPick<CR>
nnoremap <silent><leader>1 <Cmd>BufferGoto 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferGoto 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferGoto 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferGoto 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferGoto 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferGoto 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferGoto 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferGoto 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferGoto 9<CR>
nnoremap <silent><leader>w <Cmd>BufferClose<CR>

" Code navigation shortcuts
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr    <cmd>Telescope lsp_references<CR>
nnoremap <silent> gs    <cmd>Telescope lsp_document_symbols<CR>
nnoremap <silent> gd    <cmd>Telescope lsp_definitions<CR>
nnoremap <silent> gi    <cmd>Telescope lsp_implementations<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ff    <cmd>lua vim.lsp.buf.formatting()<CR>
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" open tree
nnoremap <leader>n :NvimTreeToggle<CR>

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" trouble / error list view
nnoremap <leader>x <cmd>TroubleToggle workspace_diagnostics<cr>

" telescope
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>r <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>vh <cmd>Telescope help_tags<cr>
nnoremap <leader>vc <cmd>Telescope commands<cr>
nnoremap <leader>t <cmd>TODOTelescope<cr>


" m/mm for cut
nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D

"""""" Plugins """"""
call plug#begin()
    " misc
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'kyazdani42/nvim-web-devicons' 

    " better status line
    " Plug 'feline-nvim/feline.nvim'
    Plug 'nvim-lualine/lualine.nvim'

    " themes
    Plug 'gruvbox-community/gruvbox'
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'catppuccin/nvim', {'as': 'catppuccin'}

    " nicer buffers
    Plug 'romgrk/barbar.nvim'

    " autocomplete for commands
     Plug 'gelguy/wilder.nvim'

    " tree
    Plug 'kyazdani42/nvim-tree.lua'

    " search
    Plug 'nvim-telescope/telescope.nvim'

    " Fix stupid cut on c/d/x
    Plug 'svermeulen/vim-cutlass'

    " lsp / code stuff
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'mfussenegger/nvim-dap'

    " Git 
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'TimUntersberger/neogit'
    Plug 'sindrets/diffview.nvim'

    " rust specific
    Plug 'simrat39/rust-tools.nvim'
    Plug 'rust-lang/rust.vim'

    " comment code in and out
    Plug 'numToStr/Comment.nvim'

    " auto pairs for for brackets
    Plug 'jiangmiao/auto-pairs'

    " Error list at bottom
    Plug 'folke/trouble.nvim'
  
    " hl and search for TODO FIXME etc.
    Plug 'AmeerTaweel/todo.nvim'
call plug#end()


""""""" Plugin Settings """""""
let g:tokyonight_style = "night"
let g:airline#extensions#tabline#enabled = 0
let g:rustfmt_autosave = 1 
let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha

" colorscheme gruvbox
" colorscheme tokyonight
colorscheme catppuccin

"""""" Lua Plugin Settings """""""
lua <<EOF
local nvim_lsp = require'lspconfig'

--- theme
require("catppuccin").setup()

-- easy lsp installer
require("nvim-lsp-installer").setup {}

-- Rust analyzer
local opts = {
    tools = { -- rust-tools options
        autoSetHints = false,
        hover_with_actions = true,
        inlay_hints = {
              only_current_line = true,
        },
    },
}

require('rust-tools').setup(opts)

-- nvim-treesitter
require'nvim-treesitter.configs'.setup 
{ 
  highlight = { enable = true }, 
  incremental_selection = { enable = true }, 
  textobjects = { enable = true }
}


-- OmniSharp for c#
require'lspconfig'.omnisharp.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  cmd = { "C:\\OmniSharp\\OmniSharp.exe", "--languageserver" , "--hostPID", tostring(pid) },
}

-- Autocomplete 
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

-- Better signs in sidebar
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })

end

-- Better bufferline with icons and all
-- require("bufferline").setup{}

-- Error list at bottom
require("trouble").setup {}

-- file tree
require("nvim-tree").setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
})

-- Status line
require('lualine').setup()

-- git stuff
require('gitsigns').setup()
require("neogit").setup {
   integrations = {
    diffview = true  
    },
  }

  require('Comment').setup()
  require("todo").setup {}

  local wilder = require('wilder')
  wilder.setup({modes = {':', '/', '?'}})
 wilder.set_option('renderer', wilder.wildmenu_renderer({
  highlighter = wilder.basic_highlighter(),
  separator = ' · ',
  left = {' ', wilder.wildmenu_spinner(), ' '},
  right = {' ', wilder.wildmenu_index()},
}))
EOF
