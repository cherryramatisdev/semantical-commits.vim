if exists('g:loaded_semantic_git')
	finish
endif
let g:loaded_semantic_git = 1

command! PushCurrent :call git#Push()
command! PullCurrent :call git#Pull()
command! SwitchBranch :call git#SwitchBranch()
command! CreateBranch :call git#CreateBranch()
command! SemanticalCommit :call git#Commit()
