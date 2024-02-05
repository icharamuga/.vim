" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


"---------------------------------------
"              My Settings
"---------------------------------------

set number

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

Plug 'tomasiser/vim-code-dark'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'jacoborus/tender.vim'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" Colorscheme
colorscheme tender

" Configure vim-lsp
augroup lsp
  autocmd!

  " Automatically start LSP when opening a supported file type
  autocmd FileType java,typescript,lua,python,lua lua require'nvim_lsp'.pyright.setup{}

  " Keybindings for common LSP actions
  nnoremap gd <cmd>:LspDefinition<CR>
  " Go to definition

  nnoremap K <cmd>:LspHover<CR>
  " Show hover information

  nnoremap <C-k> <cmd><CR>
  " Show signature help

  " nnoremap <leader>wa <cmd><CR>
  " Add workspace folder

  " nnoremap <leader>wr <cmd><CR>
  " Remove workspace folder

  " nnoremap <leader>wl <cmd><CR>
  " List workspace folders

  nnoremap gD <cmd>:LspDeclaration<CR>
  " Go to type definition

  nnoremap <leader>rn <cmd>:LspRename<CR>
  " Rename symbol

  nnoremap <c-@> <cmd>:LspCodeAction<CR>
  " Code action

  nnoremap gr <cmd>:LspReferences<CR>
  " Find references

  " nnoremap <leader>e <cmd><CR>
  " Show line diagnostics

  " nnoremap [d <cmd><CR>
  " Go to previous diagnostic

  " nnoremap ]d <cmd><CR>
  " Go to next diagnostic

  " nnoremap <leader>q <cmd><CR>
  " Set loclist for diagnostics

  " nnoremap <leader>f <cmd><CR>
  " Format code
augroup END

