version 7.0

" Stolen from Carlos ;)
set runtimepath+=~/.vim/_myplugins/fugitive
set runtimepath+=~/.vim/_myplugins/vimproc
let g:vimproc_dll_path = "/root/.vim/_myplugins/vimproc/autoload/proc.so"
set runtimepath+=~/.vim/_myplugins/vimshell
nmap <C-W>e :new \| VimShell bash<CR>
nmap <C-W>E :vnew \| VimShell bash<CR>
set runtimepath+=~/.vim/_myplugins/l9
set runtimepath+=~/.vim/_myplugins/fuzzyfinder
set runtimepath+=~/.vim/_myplugins/simplefold
set runtimepath+=~/.vim/_myplugins/ack
set runtimepath+=~/.vim/_myplugins/scratch

"set tags=./tags,tags,/home/website/tags
"let Tlist_Ctags_Cmd = "cd /home/website && /usr/bin/ctags -R /home/website/{cgi,lib,api}"
"let Tlist_WinWidth = 40
"map <F4> :TlistToggle<cr>
set tags=tags;/
command! Ctags !cd /home/git && ctags -R

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

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
set cursorline
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

map <Leader>t :FufBuffer<CR>
map <C-t> :FufCoverageFile<CR>

map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gm :Gcommit --amend<CR>
map <Leader>gl :Git log<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gdd :Git diff<CR>
map <Leader>gdf :Gdiff<CR>
map <Leader>gg :Git 
map <Leader>rw :!perl -Icgi -Icgi/oop -Ilib cgi/w.pl<CR>
map <Leader>srun :!su nobody -c 'perl -Icgi -Icgi/oop -Ilib %'<CR>
map <Leader>rdw :!perl -d -Icgi -Icgi/oop -Ilib cgi/w.pl<CR>
map <Leader>rd :!perl -d -Icgi -Icgi/oop -Ilib %<CR>
map <Leader>srd :!su nobody -c 'perl -d -Icgi -Icgi/oop -Ilib %'<CR>
map <Leader>prv :!prove -v %<CR>
map <Leader>sc :!perl -c -Icgi -Icgi/oop -Ilib %<CR>
map <Leader>ar :!/etc/init.d/rmg_apache restart<CR>

