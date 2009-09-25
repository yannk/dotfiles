" Only do this when not done yet for this buffer
if exists("b:loaded_perl_vim") | finish | endif
let b:loaded_perl_vim = 1

set smartindent
let perl_include_pod = 1
let perl_extended_vars = 1
let perl_fold = 1
let perl_nofold_packages=1
let perl_nofold_subs=1

map .dd :call append('.', "print STDERR Data::Dumper->Dump([]);")<CR>:call append('.', "use Data::Dumper;")<CR>

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.*/
" match OverLength /.\%>80v/

