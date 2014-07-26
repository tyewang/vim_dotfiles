map <silent> <LocalLeader>rb :wa<CR> :call _RunAll()<CR>
map <silent> <LocalLeader>rc :wa<CR> :RunRubyFocusedContext<CR>
map <silent> <LocalLeader>rf :wa<CR> :call _RunLine()<CR>
map <silent> <LocalLeader>rl :wa<CR> :call _RunLast()<CR>
map <silent> <LocalLeader>rx :wa<CR> :VimuxCloseRunner<CR>
map <silent> <LocalLeader>ri :wa<CR> :VimuxInspectRunner<CR>
map <silent> <LocalLeader>rs :!ruby -c %<CR>

map <LocalLeader>rd Orequire 'ruby-debug';debugger<ESC>
setlocal isk+=?
