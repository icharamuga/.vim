" Get the current operating system


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

"---------------------------------------
"            Vundle Settings
"---------------------------------------

filetype off

set rtp+=$HOME/.vim/bundle/vundle
let path='$HOME/.vim/bundle'
call vundle#rc('$HOME/.vim/bundle')
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tomasiser/vim-code-dark'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'jacoborus/tender.vim'
Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'ycm-core/YouCompleteMe'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call vundle#end()
filetype plugin indent on

" Colorscheme
colorscheme tender

" Configure vim-lsp
augroup lsp
  autocmd!

  " Automatically start LSP when opening a supported file type
  " autocmd FileType java,typescript,lua,python,lua lua require'nvim_lsp'.pyright.setup{}

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


nnoremap <silent> <leader>h <Plug>(YCMToggleInlayHints)
let g:ycm_confirm_extra_conf = 0

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" Tab bindings
nnoremap <leader>t :tabnew
nnoremap H :tabp
nnoremap L :tabn

" Disable swapfile
set noswapfile
