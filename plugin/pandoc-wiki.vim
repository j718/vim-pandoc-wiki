"{ Init
if v:version > 702
	if has('python3')
		let s:py_version = 'python3 '
		let s:py_env = 'python3 << EOF'
	else
		echoerr "Unable to start orgmode. Vim-pandoc-wiki depends on Vim >= 7.3 with Python3 support complied in."
		finish
	endif
else
  echoerr "Unable to start orgmode. Vim-pandoc-wiki depends on Vim >= 7.3 with Python3 support complied in."
	finish
endif
python3 << EOF
import vim, os, sys

for p in vim.eval("&runtimepath").split(','):
	dname = os.path.join(p, "plugin")
	if os.path.exists(os.path.join(dname, "wiki")):
		if dname not in sys.path:
			sys.path.append(dname)
			break

from wiki import diary
EOF
"{ Functions
"{{ Mark Text
function! MarkText() abort
let start = line("'{") + 1
call setline(start, '> ' . getline(start))
endfunction
"{{ BuildMyDiary
function! s:BuildMyDiary() abort
  python3 diary.build_index()
endfunction
"{{ Open Step
function! s:OpenStep() abort
  cd ~/repos/notes/
  e step/step.md
endfunction

"{{ Open Index
function! s:OpenIndex() abort
  cd ~/repos/notes
  e index.md
endfunction
"{{ Open Today's Journal
function! s:OpenToday() abort
  cd ~/repos/notes
  exe "e diary/" . strftime("%Y-%m-%d") . ".md"
endfunction
"{ Commands
command! BuildDiary call s:BuildMyDiary()
command! OpenIndex call s:OpenIndex()
command! OpenStep call s:OpenStep()
command! OpenToday call s:OpenToday()
"{ Mappings
nnoremap <Leader>ww :OpenIndex<CR>
nnoremap <Leader>ws :OpenStep<CR>
nnoremap <Leader>wt :OpenToday<CR>
