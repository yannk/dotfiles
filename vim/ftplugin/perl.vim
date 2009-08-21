" Only do this when not done yet for this buffer
if exists("b:loaded_perl_vim") | finish | endif
let b:loaded_perl_vim = 1
set smartindent

map .dd :call append('.', "print STDERR Data::Dumper->Dump([]);")<CR>:call append('.', "use Data::Dumper;")<CR>
