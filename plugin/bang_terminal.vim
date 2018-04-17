if exists('g:loaded_bang_terminal')
  finish
endif
let g:loaded_bang_terminal = 1
let s:cpoptions = &cpoptions
set cpoptions&vim

let s:has_term = has('nvim') ?
                \ (has('nvim-0.2.1') || !has('win32')) :
                \ (has('terminal') && has('patch-8.0.1108'))

" Vim without +terminal        - !
" Vim with +terminal or Neovim - terminal
function! s:bang(cmd)
  if empty(a:cmd)
    echoerr 'Command is empty string'
    return
  elseif !executable(&shell)
    echoerr '&shell is not executable'
    return
  endif

  if has('nvim')
    enew
    call termopen(a:cmd)
    startinsert
  else
    if &shell =~# 'cmd.exe$'
      let cmd = 'cmd /s /c "' . a:cmd . '"'
    else
      let cmd = [&shell, &shellcmdflag, a:cmd]
    endif

    call term_start(cmd)
  endif
endfunction

function! s:fix_cmd()
  let cmd = getcmdline()
  if !empty(cmd)
    if cmd ==# '!' || cmd !~# '^!'
      return cmd
    endif
    call s:bang(cmd[1:])
  endif
  return ''
endfunction

if s:has_term
  cnoremap <CR> <C-\>e<SID>fix_cmd()<CR><CR>
endif

let &cpoptions = s:cpoptions
unlet s:cpoptions
