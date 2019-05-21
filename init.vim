" plugins:
call plug#begin()
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'storyn26383/vim-vue'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'digitaltoad/vim-pug'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'iloginow/vim-stylus'
Plug 'itchyny/lightline.vim'
Plug 'tomasiser/vim-code-dark'

call plug#end()

so ~/.config/nvim/coc.vim

set noswapfile
set ignorecase
syntax on
set nocompatible
set hidden
ab w wa
set smartindent
filetype indent on
set hlsearch
set number
set cursorline
set noswapfile
set wrap!

" autoread with trigger
au FocusGained,BufEnter * :checktime
set autoread



" tabs
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif


" different cursors in different modes
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"

imap jj <Esc>
map <silent> <space>l  :CocCommand eslint.executeAutofix <CR>
map <C-l>  :CocCommand eslint.executeAutofix <CR>

" let mapleader = ","
let mapleader=" "

map <leader>s :Startify <CR>
map <leader>f :Rg <CR>

" fuzzy:
nnoremap <C-p> :Files<CR>

nmap <Tab><Tab> :Buffers<CR>
nnoremap <Leader><Tab> :Buffers<CR>
nnoremap <Leader>h :History<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" autosave everything
au FocusLost * silent! wa

" NERDTREE:
nnoremap <F3> :NERDTreeToggle <CR>
let NERDTreeShowLineNumbers=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=40

function! NTopen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! RcsycsyncTree()
    if NTopen() && !&modifiable
        NERDTreeToggle
    else
        NERDTreeFind
    endif
endfunction

nnoremap <F1> :call RcsycsyncTree() <CR>
nmap <F1> :call RcsycsyncTree() <CR>
nnoremap <S-Tab> :call RcsycsyncTree() <CR>
let g:NERDTTreeWinSize=65

" colors
" colorscheme hybrid_reverse
" colorscheme darcula
colorscheme codedark
" let g:airline_theme = "hybrid"
" let g:airline#extensions#tabline#enabled = 1

" startify
let g:startify_bookmarks = [
  \ { 'vim-config': '~/.config/nvim/init.vim'},
  \ { 'admin-panel': '~/projects/admin-black'},
  \ { 'front-black': '~/projects/front-black'},
  \ { 'mr-robot': '~/projects/mr-robot'},
  \ { 'pah-front': '~/projects/pah-fm/frontend' },
  \ { 'pah': '~/projects/pah-fm' } ,
  \ { 'nest-testing': '~/projects/nest-testing' } ,
  \ ]

let g:startify_enable_special = 0
let g:startify_lists = [
   \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
   \ { 'type': 'sessions',  'header': ['   Sessions']       },
   \ { 'type': 'files',     'header': ['   files']            },
   \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
   \ { 'type': 'commands',  'header': ['   Commands']       },
   \ ]

" gitgutter
set updatetime=100

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" let g:coc_snippet_next = '<tab>'

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" lightline
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ ['blame', 'filename'], [ 'cocstatus', 'currentfunction' ] ],
      \   'right': [ [ 'percent' ], ['gitbranch'] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'blame': 'fugitiveblame'
      \ },
      \ }


