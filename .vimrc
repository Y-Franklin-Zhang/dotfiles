" enforce safe .vimrc sourcing
set exrc
set secure
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 110 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=110
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
" turn syntax highlighting on
set t_Co=256
syntax on
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" ===================== VUNDLE BEGIN ======================================
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" --- COLORS --- 
Plugin 'colepeters/spacemacs-theme.vim'
Plugin 'arzg/vim-colors-xcode'
" syntax language packs 
Plugin 'sheerun/vim-polyglot'

" --- EDITING --- 
" semantic code auto-completion 
Plugin 'ycm-core/YouCompleteMe'
" think this is required by some other plugin? idk 
Plugin 'Shougo/vimproc.vim'
" auto-format on save 
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
" auto-complete pairs 
Plugin 'jiangmiao/auto-pairs'
" visual line/block moving 
Plugin 'matze/vim-move'
" quickly select text objects (ENTER/BS to cycle through the groups) 
Plugin 'gcmt/wildfire.vim'
" easy commenting utilities 
Plugin 'preservim/nerdcommenter'
" pull C++ prototypes into the implementation file 
Plugin 'derekwyatt/vim-protodef'
" instantly open a preview window when editing markdown files 
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
" linting 
Plugin 'dense-analysis/ale' 
" AsyncRun for running/compiling in Vim via keybindings 
" Plugin  'skywind3000/asyncrun.vim'
" Git integrated with Vim 
Plugin 'tpope/vim-fugitive'

" --- VIEW --- 
" show indent lines 
Plugin 'Yggdroot/indentLine'
" show changed line signs for git diff files 
Plugin 'airblade/vim-gitgutter'


" All of your Plugins must be added before the following line
call vundle#end()            " required
call glaive#Install()        " required for vim-format 
filetype plugin indent on    " required 

" ===================== VUNDLE END ======================================

" YCM stuff
let g:ycm_filetype_blacklist = {}
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
" close preview window automatically 
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" setup auto-formatting for code 
augroup autoformat_settings
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
    autocmd FileType java AutoFormatBuffer google-java-format
    autocmd FileType python AutoFormatBuffer yapf
    " Alternative: autocmd FileType python AutoFormatBuffer autopep8
    autocmd FileType rust AutoFormatBuffer rustfmt
    autocmd FileType vue AutoFormatBuffer prettier
augroup END

" set colorscheme 
if (has("termguicolors"))
      set termguicolors
  endif
set background=dark
colorscheme spacemacs-theme

" compile and run a single file within this directory 
noremap <C-F5> :w<CR> :silent !clear; make<CR> :!echo "--------------- Running ---------------"; echo; command time -v "./%<"<CR>
" save the current file 
nnoremap <silent><C-s> :<C-u>update<cr>
vnoremap <silent><C-s> <Esc>:update<cr>gv
inoremap <silent><C-s> <C-o>:update<cr>

" enable powerline 
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2

