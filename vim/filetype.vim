autocmd BufNewFile,BufRead *.t    setf perl
autocmd BufNewFile,BufRead *.conf setf conf

" most of my stuff is tt2 for html
autocmd BufNewFile,BufRead *.tt2  setf tt2html
autocmd BufNewFile,BufRead *.tt   setf tt2html
autocmd BufNewFile,BufRead *.tmpl setf tt2html

"     au BufNewFile,BufRead *.tt2
"             \ if ( getline(1) . getline(2) . getline(3) =~ '<\chtml'
"             \           && getline(1) . getline(2) . getline(3) !~ '<[%?]' )
"             \   || getline(1) =~ '<!DOCTYPE HTML' |
"             \   setf tt2html |
"             \ else |
"             \   setf tt2 |
"             \ endif 

"autocmd BufNewFile,BufRead *.tmpl setf html
"autocmd BufNewFile,BufRead *.tt   setf html
" define START_TAG, END_TAG
"     "ASP"
"     :let b:tt2_syn_tags = '<% %>'
"     "PHP"
"     :let b:tt2_syn_tags = '<? ?>'
"     "TT2 and HTML"
"     :let b:tt2_syn_tags = '\[% %] <!-- -->'
