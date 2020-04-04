"{ Commands
command! BuildDiary
      \ call pandoc#wiki#BuildMyDiary()
command! OpenIndex
      \ call pandoc#wiki#OpenIndex()
command! OpenStep
      \ call pandoc#wiki#OpenStep()
command! OpenToday
      \ call pandoc#wiki#OpenToday()
"{ Mappings
nnoremap <silent> <Leader>ww
      \ :call pandoc#wiki#OpenIndex()<CR>
nnoremap <silent> <Leader>ws
      \ :call pandoc#wiki#OpenFavoriteSub()<CR>
nnoremap <silent> <Leader>wt
      \ :call pandoc#wiki#OpenToday<CR>
