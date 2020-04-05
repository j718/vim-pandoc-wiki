"{ Init
if has('python3')
  py3 from importlib import reload
  py3 from vim_pandoc_wiki import diary
  py3 reload(diary)
endif

"{ Helper Function
if !exists('g:pandoc#wiki#dirs')
    let g:pandoc#wiki#dirs = ['~/pandoc-wiki']
endif
"{{ OpenWIkiFile
function! pandoc#wiki#OpenWikiFile(wiki_file, ...) abort
  if exists(a:0)
    let wiki_dir = a:0
  else
    let wiki_dir = g:pandoc#wiki#dirs[0]
  endif

  exec 'cd ' . wiki_dir
  exec 'e ' . a:wiki_file
endfunction


"{ Index File
"{{ Open Index
function! pandoc#wiki#OpenIndex() abort
  call pandoc#wiki#OpenWikiFile('index.md')
endfunction

"{ Diary
"{{ BuildMyDiary
function! pandoc#wiki#BuildMyDiary() abort
  py3 diary.build_index()
endfunction

"{{ Open Today
function! pandoc#wiki#OpenToday() abort
  let today =  "diary/" . strftime("%Y-%m-%d") . ".md"
  call pandoc#wiki#OpenWikiFile(today)
endfunction

"{ Other
"{{ Mark Text
function! pandoc#wiki#MarkText() abort
let start = line("'{")
if getline(start) == ''
  let start+=1
endif
let start_line = getline(start)
if start_line[0:1] == '> '
  call setline(start, start_line[2:])
else
  call setline(start, '> ' . start_line)
endif
endfunction

"{{ Open Favorite Sub
function! pandoc#wiki#OpenFavoriteSub() abort
  if !exists('g:pandoc#wiki#favorite_sub')
    echom "You need to set a favorite sub to use this command"
  else
    call pandoc#wiki#OpenWikiFile(g:pandoc#wiki#favorite_sub)
  endif
endfunction
