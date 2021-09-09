function s:runGitCommand(command)
  execute a:command
endfunction

function git#Push()
  call s:runGitCommand('Git ps')
endfunction

function git#Pull()
  call s:runGitCommand('Git pl')
endfunction

function! git#SwitchBranch() abort
  let l:branch_name = input('Branch name: ')
  if l:branch_name == ''
    return
  endif

  call s:runGitCommand('Git checkout ' . l:branch_name)
endfunction

function! git#CreateBranch() abort
  let l:branch_name = input('Branch name: ')

  if l:branch_name == ''
    return
  endif

  call s:runGitCommand('Git checkout -b ' . l:branch_name)
endfunction

function! git#Commit() abort
  let l:options = ['Commit type: ', 'feat', 'fix', 'chore', 'doc', 'refactor']

  let l:commit_type = inputlist(l:options)
  redraw

  if l:commit_type == 0
    return
  endif

  let l:commit_message = input('Commit message: ')
  redraw

  if l:commit_message == ''
    return
  endif

  let l:should_verify_commit = confirm('Should verify? ', "&Yes\n&No", 1)
  redraw

  let l:runner = 'Git commit -m "' .
        \ l:options[l:commit_type] .
        \ ': ' .
        \ l:commit_message .
        \ '"'

  if l:should_verify_commit == 1
    let l:runner = l:runner
  else
    let l:runner = l:runner . ' --no-verify'
  endif

  call s:runGitCommand(l:runner)
endfunction
