"""""" Settings """"""
set background=dark
set clipboard=unnamedplus
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
nnoremap <Leader>= :vertical resize +40<CR>
nnoremap <Leader>- :vertical resize -40<CR>

" Buffer navigation
nnoremap <silent> gb :BufferLinePick<CR>
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
nnoremap <silent><leader>w <Cmd>bd<CR>

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

" m/mm for cut
nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D

"""""" Plugins """"""
call plug#begin()
    " misc
    Plug 'nvim-lua/plenary.nvim'
    Plug 'kyazdani42/nvim-web-devicons' 
    Plug 'kyazdani42/nvim-web-devicons' 

    " better status line
    Plug 'feline-nvim/feline.nvim'

    " theme
    Plug 'gruvbox-community/gruvbox'

    " blazingly fast navigation
    Plug 'ggandor/lightspeed.nvim'

    " nicer buffers
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

    " tree
    Plug 'kyazdani42/nvim-tree.lua'

    " search
    Plug 'nvim-telescope/telescope.nvim'

    " Fix stupid cut on c/d/x
    Plug 'svermeulen/vim-cutlass'

    " lsp / code stuff
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

    " rust specific
    Plug 'simrat39/rust-tools.nvim'
    Plug 'rust-lang/rust.vim'

    " comment code in and out
    Plug 'tpope/vim-commentary'     

    " auto pairs for for brackets
    Plug 'jiangmiao/auto-pairs'

    " Error list at bottom
    Plug 'folke/trouble.nvim'
call plug#end()


""""""" Plugin Settings """""""
colorscheme gruvbox

let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 0
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:rustfmt_autosave = 1 

""""""" Lua Plugin Settings """""""
lua <<EOF
local nvim_lsp = require'lspconfig'

-- Rust analyzer
local opts = {
    tools = { -- rust-tools options
        autoSetHints = false,
        hover_with_actions = true,
        inlay_hints = {
            enabled = false
        },
    },
    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)

-- OmniSharp for c#
require'lspconfig'.omnisharp.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
require("bufferline").setup{}

-- Error list at bottom
require("trouble").setup {}

-- file tree
require("nvim-tree").setup({
  update_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
})

-- Status line
local gruvbox = {
    fg = '#928374',
    bg = '#1F2223',
    black ='#1B1B1B',
    skyblue = '#458588',
    cyan = '#83a597',
    green = '#689d6a',
    oceanblue = '#1d2021',
    magenta = '#fb4934',
    orange = '#fabd2f',
    red = '#cc241d',
    violet = '#b16286',
    white = '#ebdbb2',
    yellow = '#d79921',
}
local feline = require('feline')
feline.setup({
    theme = gruvbox
})
-- git stuff
require('gitsigns').setup()
EOF



