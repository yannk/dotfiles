if exists("b:loaded_python_vim") | finish | endif
let b:loaded_python_vim = 1
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.*/
" match OverLength /.\%>80v/
