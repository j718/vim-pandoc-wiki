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
	dname = os.path.join(p, "ftplugin")
	if os.path.exists(os.path.join(dname, "wiki")):
		if dname not in sys.path:
			sys.path.append(dname)
			break

from wiki import diary, test
EOF
"{ Functions
"{{ BuildMyDiary
function! BuildMyDiary()
  python3 diary.build_index()
endfunction
"{{ imgsave
function! Imgsave()
  let filename=expand("%:t")
  let img_name="images/" . localtime() . filename
  cd ~/repos/step
  execute "silent w" img_name
  call setreg("", ["![" . filename . "]" . "(../" .img_name . ")"])
  History
endfunction
"{{ Open Step
function! OpenStep()
  cd ~/repos/notes/
  e step/step.md
endfunction

"{{ Open Index
function! OpenIndex()
  cd ~/repos/notes
  e index.md
endfunction
"{{ Open Today's Journal
function! OpenToday()
  cd ~/repos/notes
  exe "e diary/" . strftime("%Y-%m-%d") . ".md"
endfunction

"{ Commands
command! BuildDiary call BuildMyDiary()

"{ Mappings
nmap <Leader>ww :call OpenIndex()<CR>
nmap <Leader>ws :call OpenStep()<CR>
nmap <Leader>wt :call OpenStep()<CR>
