lua require('basics')
lua require('plugins')
lua require('lsp')
lua require('lsp-lua')

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" disable fold for slim because it slows everything down
autocmd Syntax slim setlocal nofoldenable

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
