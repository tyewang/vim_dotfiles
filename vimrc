" ========= Setup ========
set rtp+=/usr/local/lib/python2.6/dist-packages/powerline/bindings/vim
set rtp+=/opt/homebrew/opt/fzf

set nocompatible

if &shell == "/usr/bin/sudosh"
  set shell=/bin/bash
endif

filetype off
call pathogen#infect()
filetype plugin indent on
runtime macros/matchit.vim

" ========= Options ========

compiler ruby
syntax on
set hlsearch
set number
set showmatch
set incsearch
set background=dark
set hidden
set backspace=indent,eol,start
set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set ruler
set wrap
set dir=/tmp//
set scrolloff=5
set ignorecase
set smartcase
set wildignore+=*.pyc,*.o,*.class,*.lo,.git,*/vendor/*,*/node_modules/*,*/build/*

if version >= 703
  set undodir=~/.vim/undodir
  set undofile
  set undoreload=10000 "maximum number lines to save for undo on a buffer reload
endif
set undolevels=1000 "maximum number of changes that can be undone

" Color
colorscheme vibrantink

au FileType diff colorscheme desert
au FileType git colorscheme desert
au BufWinLeave * colorscheme vibrantink

" Cursor
highlight Cursor guifg=white guibg=black
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor

" File Types

autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 omnifunc=jedi#completions
autocmd FileType tex setlocal textwidth=78
autocmd FileType ruby runtime ruby_mappings.vim
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd BufNewFile,BufRead *.txt setlocal textwidth=78
autocmd BufNewFile,BufRead *.tsx set filetype=typescript

if version >= 700
    autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
    autocmd FileType tex setlocal spell spelllang=en_us
endif

" Highlight trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

" Autoremove trailing spaces when saving the buffer
autocmd FileType ruby,c,cpp,java,php,html,py autocmd BufWritePre <buffer> :%s/\s\+$//e

" Highlight too-long lines
autocmd BufRead,InsertEnter,InsertLeave * 2match LineLengthError /\%126v.*/
highlight LineLengthError ctermbg=black guibg=black
autocmd ColorScheme * highlight LineLengthError ctermbg=black guibg=black

" Set up highlight group & retain through colorscheme changes
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Status
set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v/125)%)\           " column
set statusline+=%P                        " percentage of file

" ========= Plugin Options ========

let g:AckAllFiles = 0
let g:AckCmd = 'ack --type-add ruby=.feature --ignore-dir=tmp 2> /dev/null'

let html_use_css=1
let html_number_lines=0
let html_no_pre=1

let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1

let g:rubycomplete_buffer_loading = 1

let g:no_html_toolbar = 'yes'

let coffee_no_trailing_space_error = 1

let NERDTreeIgnore=['\.pyc', '\.o', '\.class', '\.lo']

let g:VimuxUseNearestPane = 1

let $FZF_DEFAULT_COMMAND = 'find . -name "*" -type f 2>/dev/null
                            \ | grep -v -E "tmp\/|.gitmodules|.git\/|deps\/|_build\/|node_modules\/|vendor\/"
                            \ | sed "s|^\./||"'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_tags_command = 'ctags -R --exclude=".git\|.svn\|log\|tmp\|db\|pkg" --extra=+f --langmap=Lisp:+.clj'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'up': '~20%' }



let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#smart_auto_mappings = 0

let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['python', 'pyflakes']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['eslint']

let g:jsx_ext_required = 0

" ========= Shortcuts ========

" NERDTree
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>

" FZF
function! SmartFuzzy()
  let root = split(system('git rev-parse --show-toplevel'), '\n')
  if len(root) == 0 || v:shell_error
    Files
  else
    GFiles -co --exclude-standard -- . ':!:vendor/*'
  endif
endfunction

command! -nargs=* SmartFuzzy :call SmartFuzzy()
map <silent> <leader>ff :SmartFuzzy<CR>
map <silent> <leader>fg :GFiles<CR>
map <silent> <leader>fb :Buffers<CR>
map <silent> <leader>ft :Tags<CR>

" Ack
map <LocalLeader>aw :Ack '<C-R><C-W>'

" TComment
map <silent> <LocalLeader>cc :TComment<CR>
map <silent> <LocalLeader>uc :TComment<CR>

" Vimux
map <silent> <LocalLeader>rl :wa<CR> :VimuxRunLastCommand<CR>
map <silent> <LocalLeader>vi :wa<CR> :VimuxInspectRunner<CR>
map <silent> <LocalLeader>vk :wa<CR> :VimuxInterruptRunner<CR>
map <silent> <LocalLeader>vx :wa<CR> :VimuxClosePanes<CR>
map <silent> <LocalLeader>vp :VimuxPromptCommand<CR>
vmap <silent> <LocalLeader>vs "vy :call VimuxRunCommand(@v)<CR>
nmap <silent> <LocalLeader>vs vip<LocalLeader>vs<CR>

map <silent> <LocalLeader>rt :!ctags -R --exclude=".git\|.svn\|log\|tmp\|db\|pkg" --extra=+f --langmap=Lisp:+.clj<CR>

map <silent> <LocalLeader>gd :e product_diff.diff<CR>:%!git diff<CR>:setlocal buftype=nowrite<CR>
map <silent> <LocalLeader>pd :e product_diff.diff<CR>:%!svn diff<CR>:setlocal buftype=nowrite<CR>

map <silent> <LocalLeader>nh :nohls<CR>

map <silent> <LocalLeader>bd :bufdo :bd<CR>

cnoremap <Tab> <C-L><C-D>

nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> Y y$

map <silent> <LocalLeader>ws :highlight clear ExtraWhitespace<CR>

" Vimux Nose Test
autocmd FileType python map <silent> <LocalLeader>rf :wa<CR> :RunFocusedNoseTests<CR>
autocmd FileType python map <silent> <LocalLeader>rb :wa<CR> :RunAllNoseTests<CR>

" Vimux Jest Test
autocmd FileType javascript,typescript map <silent> <LocalLeader>rf :wa<CR> :RunJestFocused<CR>
autocmd FileType javascript,typescript  map <silent> <LocalLeader>rb :wa<CR> :RunJestOnBuffer<CR>

" Prettier
autocmd FileType javascript map <silent> <leader>pt :Prettier<CR>
autocmd FileType python map <silent> <leader>pt :Black<CR>

" Tsuquyomi
let g:tsuquyomi_disable_quickfix = 1
autocmd FileType javascript,typescript map <silent> <LocalLeader>g :TsuDefinition<CR>

" ========= Insert Shortcuts ========

imap <C-L> <SPACE>=><SPACE>
imap <C-D> import ipdb; ipdb.sset_trace()
" Remapping of autocomplete trigger
imap <C-SPACE> <C-N>
imap <C-@> <C-Space>

" ========= Functions ========

command SudoW w !sudo tee %

" http://techspeak.plainlystated.com/2009/08/vim-tohtml-customization.html
function! DivHtml(line1, line2)
  exec a:line1.','.a:line2.'TOhtml'
  %g/<style/normal $dgg
  %s/<\/style>\n<\/head>\n//
  %s/body {/.vim_block {/
  %s/<body\(.*\)>\n/<div class="vim_block"\1>/
  %s/<\/body>\n<\/html>/<\/div>
  "%s/\n/<br \/>\r/g

  set nonu
endfunction
command -range=% DivHtml :call DivHtml(<line1>,<line2>)

nnoremap <silent> <Leader>gw :Ggrep! "\<<cword>\>"<CR>:cwin<CR>

function! Trim()
  %s/\s*$//
endfunction
command! -nargs=0 Trim :call Trim()
nnoremap <silent> <Leader>cw :Trim<CR>
