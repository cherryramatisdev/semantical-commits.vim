if exists('g:loaded_semantic_git')
	finish
endif
let g:loaded_semantic_git = 1

command! PushCurrent :call git#PushCurrent()
command! PullCurrent :call git#PullCurrent()
command! Push :call git#Push()
command! Pull :call git#Pull()
command! SwitchBranch :call git#SwitchBranch()
command! CreateBranch :call git#CreateBranch()
command! SemanticalCommit :call git#Commit()
