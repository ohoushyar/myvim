version 7.0

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

set runtimepath+=$HOME/.vim/bundle/vundle
call vundle#rc()

" Vundle requirement
Bundle 'gmarik/vundle'

Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'ack.vim'
Bundle 'simplefold'
Bundle 'taglist.vim'
Bundle 'tComment'
Bundle 'fugitive.vim'
Bundle 'The-NERD-tree'
Bundle 'Tabular'
"Doesn't really work with Fugitive. Disable for now!
"Bundle 'bling/vim-airline'

filetype plugin indent on

"set tags=./tags,tags,/home/website/tags
set tags=tags;
command! Ctags !cd /home/git && ctags -R


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
" set tw=72

set ai
set hid
set showcmd
set incsearch
set vb
set scrolloff=5
set statusline=%F%m%r%h%w\ [%{&ff}]\ %y\ [CHR=%b/0x%B]\ [POS=%04l,%03c(%03v)]\ [%p%%]\ [LEN=%L]\ %{fugitive#statusline()}
set laststatus=2

let perl_fold=1
let perl_nofold_packages=1
let c_no_comment_fold=1
let perl_include_pod=1
let g:omni_sql_no_default_maps=1

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  colorscheme darkblue
  set hlsearch
  set cursorline
  set t_Co=16
  hi CursorLine term=bold cterm=bold ctermbg=darkgrey
  set cursorcolumn
endif

" Fix number of colors for xterm
if &term =~ "xterm" && &t_Co == 8
  set t_Co=16
  hi CursorLine term=NONE cterm=bold ctermbg=8
  hi Folded ctermbg=8 ctermfg=14
  hi FoldColumn ctermbg=8 ctermfg=14
  hi Visual term=NONE cterm=bold ctermbg=10 ctermfg=8
  hi Search term=reverse cterm=bold ctermbg=11 ctermfg=0
endif

set bs=2
set ignorecase
set showmatch
set cindent " set smartindent
set smarttab
set expandtab
set ruler
set shiftwidth=4
set ls=2
set errorformat=\"../../%f\"\\,%*[^0-9]%l:\ %m
set ch=2
set wrap
nmap ' :cn
nmap <F1> <Esc>
imap <F1> <Esc>



" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
"command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
"	 	\ | wincmd p | diffthis

" -----------------------------------------
"
" Lines below are my vim configurations
"
" -----------------------------------------

source ~/.vim/autoload/abbr.vim

set number

set tabstop=4    "An indentation level every four columns"
set expandtab    "Convert all tabs typed into spaces"
set shiftwidth=4 "Indent/outdent by four columns"
set shiftround   "Always indent.outdent to the nearest tabstop"

set list                        "enable viewing tabs
set listchars=tab:>-,trail:-    "make it nicer

" set textwidth=80 "Use 80 column lines

let Grep_Default_Filelist = '*.pm *.pl *.cgi *.css *.js *.html *.t *.tt *.sql'

nnoremap <silent> <F8> :TlistToggle<CR>

" Perl syntax relevants
" let perl_fold = 1
let perl_extended_vars = 1

" Enable syntax highlight for *.tt as html
au BufNewFile,BufRead *.tt set filetype=html


" ToggleMouse on <F12>
nnoremap <F12> :call ToggleMouse()<CR>
function! ToggleMouse()
    if &mouse=='a'
        set mouse-=a
        echo "Mouse usage disable"
    else
        set mouse=a
        echo "Mouse usage enable"
    endif
endfunction

let g:gitgrepprg="git\\ grep\\ -n"
function! GitGrep(args)
    let grepprg_bak=&grepprg
    exec "set grepprg=" . g:gitgrepprg
    execute "silent! grep " . a:args
    botright copen
    let &grepprg=grepprg_bak
    exec "redraw!"
endfunction
command! -nargs=* -complete=file GitGrep call GitGrep(<q-args>)
map <Leader>gg :GitGrep <C-r><C-w>

map <Leader>n :set number!<CR>
map <Leader>l :set list!<CR>

map <Leader>t :FufBuffer<CR>
map <C-t> :FufCoverageFile<CR>

map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gm :Gcommit --amend<CR>
map <Leader>gl :Git log<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gdd :Git diff<CR>
map <Leader>gdf :Gdiff<CR>

map <Leader>tr :NERDTreeToggle<CR>

" Tabularize json
map <Leader>ij :Tabularize /:\z\s/<CR>

map <Leader>r :!perl %<CR>
map <Leader>rd :!perl -d %<CR>
map <Leader>prv :!prove -v %<CR>
map <Leader>sc :!perl -c %<CR>
map <Leader>a :Ack <C-r><C-w>
map <Leader>rp :%s/<C-r>0//gc

" Perl module opener
map <Leader>omv y<C-w>np0ie lib/<esc>A.pm<esc>:%s/::/\//g<CR>:noh<CR>v$y:bd!<CR>:<C-r>0<CR>
map <Leader>om 0f<Space>eT<Space>vt;<Leader>omv
map <Leader>oms 0f<Space>eT<Space>vt<Space><Leader>omv

" save
map <C-s> <esc>:w<CR>

vmap ,f :! $HOME/myvim/_myplugins/perl_postfix_toggle/postfix_toggle.pl<CR>
noremap ,t  :!prove -lv --merge -It/tests %<CR>
noremap ,T  :!prove -lv --merge t/run.t<CR>

" courtesy Bart Lantz: coderwall
cmap w!! %!sudo tee > /dev/null %
