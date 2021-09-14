function s:runGitCommand(command)
  execute '!' . a:command
endfunction

function! s:getCurrentBranch() abort
  return system('git branch --show-current')
endfunction

function git#Push()
  let l:branch_name = input('Choose branch: ', '', 'customlist,git#GetBranches')
  redraw

  if len(l:branch_name) == 0
    return
  endif

  call s:runGitCommand('git push origin ' . l:branch_name)
endfunction

function git#Pull()
  let l:branch_name = input('Choose branch: ', '', 'customlist,git#GetBranches')
  redraw

  if len(l:branch_name) == 0
    return
  endif

  call s:runGitCommand('git pull origin ' . l:branch_name)
endfunction

function git#PushCurrent()
  call s:runGitCommand('git push origin ' . s:getCurrentBranch())
endfunction

function git#PullCurrent()
  call s:runGitCommand('git pull origin ' . s:getCurrentBranch())
endfunction

function! git#GetBranches(...) abort
  return systemlist("git branch | sed 's/* //'")
endfunction

function! git#SwitchBranch() abort
  let l:branch_name = input('Branch name: ', '', 'customlist,git#GetBranches')
  if l:branch_name == ''
    return
  endif

  call s:runGitCommand('git checkout ' . l:branch_name)
endfunction

function! git#CreateBranch() abort
  let l:branch_name = input('Branch name: ')

  if l:branch_name == ''
    return
  endif

  call s:runGitCommand('git checkout -b ' . l:branch_name)
endfunction

function! git#GetCommitTypes(...) abort
  return ['feat', 'fix', 'chore', 'doc', 'refactor']
endfunction

function! git#Commit() abort
  let l:commit_type = input('Commit type: ', '', 'customlist,git#GetCommitTypes')
  redraw

  if len(l:commit_type) == 0
    return
  endif

  let l:commit_message = input('Commit message: ')
  redraw

  if l:commit_message == ''
    return
  endif

  let l:should_verify_commit = confirm('Should verify? ', "&Yes\n&No", 1)
  redraw

  let l:runner = 'git commit -m "' .
        \ l:commit_type .
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
