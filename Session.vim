let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <Plug>allmlXmlV ="&#".getchar().";"
inoremap <silent> <Plug>NERDCommenterInInsert  <BS>:call NERDComment(0, "insert")
map! <S-Insert> <MiddleMouse>
nnoremap  :BufExplorer
nnoremap  :FuzzyFinderTextMate
snoremap <silent> 	 i<Right>=TriggerSnippet()
nnoremap  :nohls
snoremap ' b<BS>'
vmap <silent> ,e <Plug>CamelCaseMotion_e
vmap <silent> ,b <Plug>CamelCaseMotion_b
vmap <silent> ,w <Plug>CamelCaseMotion_w
omap <silent> ,e <Plug>CamelCaseMotion_e
omap <silent> ,b <Plug>CamelCaseMotion_b
omap <silent> ,w <Plug>CamelCaseMotion_w
nmap <silent> ,e <Plug>CamelCaseMotion_e
nmap <silent> ,b <Plug>CamelCaseMotion_b
nmap <silent> ,w <Plug>CamelCaseMotion_w
nmap ,ca <Plug>NERDCommenterAltDelims
vmap ,cA <Plug>NERDCommenterAppend
nmap ,cA <Plug>NERDCommenterAppend
vmap ,c$ <Plug>NERDCommenterToEOL
nmap ,c$ <Plug>NERDCommenterToEOL
vmap ,cu <Plug>NERDCommenterUncomment
nmap ,cu <Plug>NERDCommenterUncomment
vmap ,cn <Plug>NERDCommenterNest
nmap ,cn <Plug>NERDCommenterNest
vmap ,cb <Plug>NERDCommenterAlignBoth
nmap ,cb <Plug>NERDCommenterAlignBoth
vmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cl <Plug>NERDCommenterAlignLeft
vmap ,cy <Plug>NERDCommenterYank
nmap ,cy <Plug>NERDCommenterYank
vmap ,ci <Plug>NERDCommenterInvert
nmap ,ci <Plug>NERDCommenterInvert
vmap ,cs <Plug>NERDCommenterSexy
nmap ,cs <Plug>NERDCommenterSexy
vmap ,cm <Plug>NERDCommenterMinimal
nmap ,cm <Plug>NERDCommenterMinimal
vmap ,c  <Plug>NERDCommenterToggle
nmap ,c  <Plug>NERDCommenterToggle
vmap ,cc <Plug>NERDCommenterComment
nmap ,cc <Plug>NERDCommenterComment
inoremap ï o
noremap Q gq
xmap S <Plug>VSurround
nnoremap Y y$
vmap [% [%m'gv``
nmap <silent> \bv :VSBufExplorer
nmap <silent> \bs :HSBufExplorer
nmap <silent> \be :BufExplorer
nmap <silent> \p :NERDTreeToggle
vmap ]% ]%m'gv``
vmap a% [%v]%
nmap cs <Plug>Csurround
nmap ds <Plug>Dsurround
nmap gx <Plug>NetrwBrowseX
vmap <silent> i,e <Plug>CamelCaseMotion_ie
vmap <silent> i,b <Plug>CamelCaseMotion_ib
vmap <silent> i,w <Plug>CamelCaseMotion_iw
omap <silent> i,e <Plug>CamelCaseMotion_ie
omap <silent> i,b <Plug>CamelCaseMotion_ib
omap <silent> i,w <Plug>CamelCaseMotion_iw
xmap s <Plug>Vsurround
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
snoremap <Left> bi
snoremap <Right> a
snoremap <BS> b<BS>
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nmap <silent> <Plug>NERDCommenterAppend :call NERDComment(0, "append")
nnoremap <silent> <Plug>NERDCommenterToEOL :call NERDComment(0, "toEOL")
vnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment(1, "uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment(0, "uncomment")
vnoremap <silent> <Plug>NERDCommenterNest :call NERDComment(1, "nested")
nnoremap <silent> <Plug>NERDCommenterNest :call NERDComment(0, "nested")
vnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment(1, "alignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment(0, "alignBoth")
vnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment(1, "alignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment(0, "alignLeft")
vmap <silent> <Plug>NERDCommenterYank :call NERDComment(1, "yank")
nmap <silent> <Plug>NERDCommenterYank :call NERDComment(0, "yank")
vnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment(1, "invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment(0, "invert")
vnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment(1, "sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment(0, "sexy")
vnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment(1, "minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment(0, "minimal")
vnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment(1, "toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment(0, "toggle")
vnoremap <silent> <Plug>NERDCommenterComment :call NERDComment(1, "norm")
nnoremap <silent> <Plug>NERDCommenterComment :call NERDComment(0, "norm")
map <S-Insert> <MiddleMouse>
imap S <Plug>ISurround
imap s <Plug>Isurround
inoremap <silent> 	 =TriggerSnippet()
inoremap  :nohls
imap  <Plug>DiscretionaryEnd
inoremap <silent> 	 =ShowAvailableSnips()
imap  <Plug>Isurround
imap  <Plug>AlwaysEnd
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set background=dark
set backspace=indent,eol,start
set completefunc=syntaxcomplete#Complete
set errorformat=%D(in\\\ %f),%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Failure:,%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Error:,%+A'%.%#'\\\ FAILED,%C%.%#(eval)%.%#,%C-e:%.%#,%C%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%C%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%C%.%#/vendor/rails/%.%#,%C\\\ %\\\\+On\\\ line\\\ #%l\\\ of\\\ %f,%CActionView::TemplateError:\\\ compile\\\ error,%Ctest_%.%#(%.%#):%#,%C%.%#\\\ [%f:%l]:,%C\\\ \\\ \\\ \\\ [%f:%l:%.%#,%C\\\ \\\ \\\ \\\ %f:%l:%.%#,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#]:,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#,%Z%f:%l:\\\ %#%m,%Z%f:%l:,%C%m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ %m,%-G%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%-G%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%-G%.%#/vendor/rails/%.%#,%-G%.%#%\\\\d%\\\\d:%\\\\d%\\\\d:%\\\\d%\\\\d%.%#,%-G%\\\\s%#from\\\ %.%#,%f:%l:\\\ %#%m,%-G%.%#
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=es
set hidden
set history=1000
set hlsearch
set iminsert=0
set incsearch
set indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when
set iskeyword=@,48-57,_,192-255,$
set laststatus=2
set listchars=tab:\ \ ,extends:>,precedes:<
set makeprg=rake
set mouse=a
set printoptions=paper:a4
set ruler
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim72,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after
set scrolloff=3
set shiftwidth=4
set showcmd
set sidescroll=1
set sidescrolloff=7
set softtabstop=4
set statusline=%f%#warningmsg#%{&ff!='unix'?'['.&ff.']':''}%*%#warningmsg#%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}%*%h%y%r%m%#error#%{StatuslineTabWarning()}%*%{StatuslineTrailingSpaceWarning()}%{StatuslineLongLineWarning()}%#warningmsg#%{SyntasticStatuslineFlag()}%*%#error#%{&paste?'[paste]':''}%*%=%{StatuslineCurrentHighlight()}\ \ %c,%l/%L\ %P
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set termencoding=utf-8
set updatetime=500
set virtualedit=block,insert
set wildignore=*.o,*.obj,*~
set wildmenu
set wildmode=list:longest
set window=48
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/dev/ruby/motoex
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +15 app/views/layouts/application.html.erb
badd +82 app/stylesheets/style.less
badd +25 app/views/archivos/index.html.erb
badd +1 ~/.vim/snippets/ruby-rails/va.snippet
badd +0 ~/.vim/snippets/ruby-rails/vpo.snippet
badd +0 ~/.vim/snippets/ruby-rails/vu.snippet
badd +16 app/views/archivos/_form.html.erb
badd +4 app/views/usuario_sessiones/new.html.erb
badd +0 app/views/usuario_sessiones/_form.html.erb
badd +0 config/routes.rb
args ~/.vim/snippets/ruby-rails/vu.snippet
edit app/views/usuario_sessiones/_form.html.erb
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 84 + 103) / 206)
exe 'vert 2resize ' . ((&columns * 121 + 103) / 206)
argglobal
let s:cpo_save=&cpo
set cpo&vim
imap <buffer> <SNR>29_allmlOclose  ><Left><Left>
inoremap <buffer> <SNR>29_allmlOopen <%= 
inoremap <buffer> <SNR>29_xhtmltrans <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
inoremap <buffer> <SNR>29_htmltrans <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> \dxx <Plug>allmlLineXmlDecode
nmap <buffer> \exx <Plug>allmlLineXmlEncode
nmap <buffer> \duu <Plug>allmlLineUrlDecode
nmap <buffer> \euu <Plug>allmlLineUrlEncode
map <buffer> \dx <Plug>allmlXmlDecode
map <buffer> \ex <Plug>allmlXmlEncode
map <buffer> \du <Plug>allmlUrlDecode
map <buffer> \eu <Plug>allmlUrlEncode
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
imap <buffer> & <Plug>allmlXmlV
imap <buffer> % <Plug>allmlUrlV
imap <buffer> & <Plug>allmlXmlEncode
imap <buffer> % <Plug>allmlUrlEncode
imap <buffer> " <NL>I<# A >F<NL>s
imap <buffer> ' <#  >2hi
inoremap <buffer> _ <NL>I<% A -%>F<NL>s
inoremap <buffer> - <%  -%>3hi
imap <buffer> ] <>O
inoremap <buffer> > %>
inoremap <buffer> < <%
imap <buffer>  /
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=RubyBalloonexpr()
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=:#
setlocal commentstring=<%#%s%>
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'eruby'
setlocal filetype=eruby
endif
setlocal foldcolumn=0
set nofoldenable
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
set foldnestmax=3
setlocal foldnestmax=3
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=GetErubyIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=ri\ -T
set linebreak
setlocal linebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,~/dev/ruby/motoex,~/dev/ruby/motoex/app,~/dev/ruby/motoex/app/models,~/dev/ruby/motoex/app/controllers,~/dev/ruby/motoex/app/helpers,~/dev/ruby/motoex/config,~/dev/ruby/motoex/lib,~/dev/ruby/motoex/app/views,~/dev/ruby/motoex/app/views/usuario_sessiones,~/dev/ruby/motoex/public,~/dev/ruby/motoex/test,~/dev/ruby/motoex/test/unit,~/dev/ruby/motoex/test/functional,~/dev/ruby/motoex/test/integration,~/dev/ruby/motoex/spec,~/dev/ruby/motoex/spec/models,~/dev/ruby/motoex/spec/controllers,~/dev/ruby/motoex/spec/helpers,~/dev/ruby/motoex/spec/views,~/dev/ruby/motoex/spec/lib,~/dev/ruby/motoex/app/*,~/dev/ruby/motoex/vendor,~/dev/ruby/motoex/vendor/plugins/*/lib,~/dev/ruby/motoex/vendor/plugins/*/test,~/dev/ruby/motoex/vendor/rails/*/lib,~/dev/ruby/motoex/vendor/rails/*/test,/usr/lib/ruby/gems/1.8/gems/gemcutter-0.1.3/lib,/usr/local/lib/site_ruby/1.8,/usr/local/lib/site_ruby/1.8/x86_64-linux,/usr/local/lib/site_ruby,/usr/lib/ruby/vendor_ruby/1.8,/usr/lib/ruby/vendor_ruby/1.8/x86_64-linux,/usr/lib/ruby/vendor_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/x86_64-linux,,~/.gem/ruby/1.8/gems/parseexcel-0.5.2/lib,/usr/lib/ruby/gems/1.8/gems/GData-0.0.4/lib,/usr/lib/ruby/gems/1.8/gems/RubyInline-3.8.3/lib,/usr/lib/ruby/gems/1.8/gems/Selenium-1.1.14/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.4/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/addressable-2.1.0/lib,/usr/lib/ruby/gems/1.8/gems/authlogic-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/binarylogic-authlogic-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/binarylogic-searchlogic-2.3.5/lib,/usr/lib/ruby/gems/1.8/gems/bind-0.2.8/lib,/usr/lib/ruby/gems/1.8/gems/builder-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/cgi_multipart_eof_fix-2.5.0/lib,/usr/lib/ruby/gems/1.8/gems/cheat-1.2.1/lib,/usr/lib/ruby/gems/1.8/gems/columnize-0.3.1/lib,/usr/lib/ruby/gems/1.8/gems/commander-4.0.0/lib,/usr/lib/ruby/gems/1.8/gems/cucumber-0.3.104/lib,/usr/lib/ruby/gems/1.8/gems/daemons-1.0.10/lib,/usr/lib/ruby/gems/1.8/gems/datamapper-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/diff-lcs-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/dm-aggregates-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-constraints-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-core-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-migrations-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-serializer-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-timestamps-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-types-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-validations-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/extlib-0.9.13/lib,/usr/lib/ruby/gems/1.8/gems/factory_girl-1.2.3/lib,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.7/ext,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.7/lib,/usr/lib/ruby/gems/1.8/gems/gem_plugin-0.2.3/lib,/usr/lib/ruby/gems/1.8/gems/gemcutter-0.1.3/lib,/usr/lib/ruby/gems/1.8/gems/haml-2.2.6/lib,/usr/lib/ruby/gems/1.8/gems/highline-1.5.1/lib,/usr/lib/ruby/gems/1.8/gems/hirb-0.2.6/lib,/usr/lib/ruby/gems/1.8/gems/hoe-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/hpricot-0.8.1/lib,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/ext,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/ext/json/ext,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/lib,/usr/lib/ruby/gems/1.8/gems/json_pure-1.1.9/lib,/usr/lib/ruby/gems/1.8/gems/jspec-2.11.10/lib,/usr/lib/ruby/gems/1.8/gems/justinfrench-formtastic-0.2.4/lib,/usr/lib/ruby/gems/1.8/gems/less-1.1.13/lib,/usr/lib/ruby/gems/1.8/gems/libxml-ruby-1.1.3/ext/libxml,/usr/lib/ruby/gems/1.8/gems/libxml-ruby-1.1.3/lib,/usr/lib/ruby/gems/1.8/gems/linecache-0.43/lib,/usr/lib/ruby/gems/1.8/gems/macaddr-1.0.0/lib,/usr/lib/ruby/gems/1.8/gems/mislav-will_paginate-2.3.11/lib,/usr/lib/ruby/gems/1.8/gems/mocha-0.9.8/lib,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/ext,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/lib,/usr/lib/ruby/gems/1.8/gems/net-scp-1.0.2/lib,/usr/lib/ruby/gems/1.8/gems/net-ssh-2.0.15/lib,/usr/lib/ruby/gems/1.8/gems/nokogiri-1.3.3/ext,/usr/lib/ruby/gems/1.8/gems/nokogi
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%f%#warningmsg#%{&ff!='unix'?'['.&ff.']':''}%*%#warningmsg#%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}%*%h%y%{RailsStatusline()}%r%m%#error#%{StatuslineTabWarning()}%*%{StatuslineTrailingSpaceWarning()}%{StatuslineLongLineWarning()}%#warningmsg#%{SyntasticStatuslineFlag()}%*%#error#%{&paste?'[paste]':''}%*%=%{StatuslineCurrentHighlight()}\ \ %c,%l/%L\ %P
setlocal suffixesadd=.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.rb,.css,.js,.html,.yml,.csv
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'eruby'
setlocal syntax=eruby
endif
setlocal tabstop=8
setlocal tags=~/dev/ruby/motoex/tmp/tags,./tags,./TAGS,tags,TAGS,~/dev/ruby/motoex/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 12 - ((11 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 08l
wincmd w
argglobal
edit app/views/archivos/_form.html.erb
let s:cpo_save=&cpo
set cpo&vim
imap <buffer> <SNR>29_allmlOclose  ><Left><Left>
inoremap <buffer> <SNR>29_allmlOopen <%= 
inoremap <buffer> <SNR>29_xhtmltrans <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
inoremap <buffer> <SNR>29_htmltrans <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> \dxx <Plug>allmlLineXmlDecode
nmap <buffer> \exx <Plug>allmlLineXmlEncode
nmap <buffer> \duu <Plug>allmlLineUrlDecode
nmap <buffer> \euu <Plug>allmlLineUrlEncode
map <buffer> \dx <Plug>allmlXmlDecode
map <buffer> \ex <Plug>allmlXmlEncode
map <buffer> \du <Plug>allmlUrlDecode
map <buffer> \eu <Plug>allmlUrlEncode
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
imap <buffer> & <Plug>allmlXmlV
imap <buffer> % <Plug>allmlUrlV
imap <buffer> & <Plug>allmlXmlEncode
imap <buffer> % <Plug>allmlUrlEncode
imap <buffer> " <NL>I<# A >F<NL>s
imap <buffer> ' <#  >2hi
inoremap <buffer> _ <NL>I<% A -%>F<NL>s
inoremap <buffer> - <%  -%>3hi
imap <buffer> ] <>O
inoremap <buffer> > %>
inoremap <buffer> < <%
imap <buffer>  /
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=RubyBalloonexpr()
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=:#
setlocal commentstring=<%#%s%>
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'eruby'
setlocal filetype=eruby
endif
setlocal foldcolumn=0
set nofoldenable
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
set foldnestmax=3
setlocal foldnestmax=3
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=GetErubyIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=ri\ -T
set linebreak
setlocal linebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,~/dev/ruby/motoex,~/dev/ruby/motoex/app,~/dev/ruby/motoex/app/models,~/dev/ruby/motoex/app/controllers,~/dev/ruby/motoex/app/helpers,~/dev/ruby/motoex/config,~/dev/ruby/motoex/lib,~/dev/ruby/motoex/app/views,~/dev/ruby/motoex/app/views/archivos,~/dev/ruby/motoex/public,~/dev/ruby/motoex/test,~/dev/ruby/motoex/test/unit,~/dev/ruby/motoex/test/functional,~/dev/ruby/motoex/test/integration,~/dev/ruby/motoex/spec,~/dev/ruby/motoex/spec/models,~/dev/ruby/motoex/spec/controllers,~/dev/ruby/motoex/spec/helpers,~/dev/ruby/motoex/spec/views,~/dev/ruby/motoex/spec/lib,~/dev/ruby/motoex/app/*,~/dev/ruby/motoex/vendor,~/dev/ruby/motoex/vendor/plugins/*/lib,~/dev/ruby/motoex/vendor/plugins/*/test,~/dev/ruby/motoex/vendor/rails/*/lib,~/dev/ruby/motoex/vendor/rails/*/test,/usr/lib/ruby/gems/1.8/gems/gemcutter-0.1.3/lib,/usr/local/lib/site_ruby/1.8,/usr/local/lib/site_ruby/1.8/x86_64-linux,/usr/local/lib/site_ruby,/usr/lib/ruby/vendor_ruby/1.8,/usr/lib/ruby/vendor_ruby/1.8/x86_64-linux,/usr/lib/ruby/vendor_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/x86_64-linux,,~/.gem/ruby/1.8/gems/parseexcel-0.5.2/lib,/usr/lib/ruby/gems/1.8/gems/GData-0.0.4/lib,/usr/lib/ruby/gems/1.8/gems/RubyInline-3.8.3/lib,/usr/lib/ruby/gems/1.8/gems/Selenium-1.1.14/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.4/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/addressable-2.1.0/lib,/usr/lib/ruby/gems/1.8/gems/authlogic-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/binarylogic-authlogic-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/binarylogic-searchlogic-2.3.5/lib,/usr/lib/ruby/gems/1.8/gems/bind-0.2.8/lib,/usr/lib/ruby/gems/1.8/gems/builder-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/cgi_multipart_eof_fix-2.5.0/lib,/usr/lib/ruby/gems/1.8/gems/cheat-1.2.1/lib,/usr/lib/ruby/gems/1.8/gems/columnize-0.3.1/lib,/usr/lib/ruby/gems/1.8/gems/commander-4.0.0/lib,/usr/lib/ruby/gems/1.8/gems/cucumber-0.3.104/lib,/usr/lib/ruby/gems/1.8/gems/daemons-1.0.10/lib,/usr/lib/ruby/gems/1.8/gems/datamapper-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/diff-lcs-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/dm-aggregates-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-constraints-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-core-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-migrations-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-serializer-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-timestamps-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-types-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-validations-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/extlib-0.9.13/lib,/usr/lib/ruby/gems/1.8/gems/factory_girl-1.2.3/lib,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.7/ext,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.7/lib,/usr/lib/ruby/gems/1.8/gems/gem_plugin-0.2.3/lib,/usr/lib/ruby/gems/1.8/gems/gemcutter-0.1.3/lib,/usr/lib/ruby/gems/1.8/gems/haml-2.2.6/lib,/usr/lib/ruby/gems/1.8/gems/highline-1.5.1/lib,/usr/lib/ruby/gems/1.8/gems/hirb-0.2.6/lib,/usr/lib/ruby/gems/1.8/gems/hoe-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/hpricot-0.8.1/lib,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/ext,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/ext/json/ext,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/lib,/usr/lib/ruby/gems/1.8/gems/json_pure-1.1.9/lib,/usr/lib/ruby/gems/1.8/gems/jspec-2.11.10/lib,/usr/lib/ruby/gems/1.8/gems/justinfrench-formtastic-0.2.4/lib,/usr/lib/ruby/gems/1.8/gems/less-1.1.13/lib,/usr/lib/ruby/gems/1.8/gems/libxml-ruby-1.1.3/ext/libxml,/usr/lib/ruby/gems/1.8/gems/libxml-ruby-1.1.3/lib,/usr/lib/ruby/gems/1.8/gems/linecache-0.43/lib,/usr/lib/ruby/gems/1.8/gems/macaddr-1.0.0/lib,/usr/lib/ruby/gems/1.8/gems/mislav-will_paginate-2.3.11/lib,/usr/lib/ruby/gems/1.8/gems/mocha-0.9.8/lib,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/ext,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/lib,/usr/lib/ruby/gems/1.8/gems/net-scp-1.0.2/lib,/usr/lib/ruby/gems/1.8/gems/net-ssh-2.0.15/lib,/usr/lib/ruby/gems/1.8/gems/nokogiri-1.3.3/ext,/usr/lib/ruby/gems/1.8/gems/nokogiri-1.3.3/
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%f%#warningmsg#%{&ff!='unix'?'['.&ff.']':''}%*%#warningmsg#%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}%*%h%y%{RailsStatusline()}%r%m%#error#%{StatuslineTabWarning()}%*%{StatuslineTrailingSpaceWarning()}%{StatuslineLongLineWarning()}%#warningmsg#%{SyntasticStatuslineFlag()}%*%#error#%{&paste?'[paste]':''}%*%=%{StatuslineCurrentHighlight()}\ \ %c,%l/%L\ %P
setlocal suffixesadd=.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.rb,.css,.js,.html,.yml,.csv
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'eruby'
setlocal syntax=eruby
endif
setlocal tabstop=8
setlocal tags=~/dev/ruby/motoex/tmp/tags,./tags,./TAGS,tags,TAGS,~/dev/ruby/motoex/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 16 - ((15 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
16
normal! 01l
wincmd w
exe 'vert 1resize ' . ((&columns * 84 + 103) / 206)
exe 'vert 2resize ' . ((&columns * 121 + 103) / 206)
tabedit app/stylesheets/style.less
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 103 + 103) / 206)
exe 'vert 2resize ' . ((&columns * 102 + 103) / 206)
argglobal
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=%D(in\\\ %f),%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Failure:,%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Error:,%+A'%.%#'\\\ FAILED,%C%.%#(eval)%.%#,%C-e:%.%#,%C%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%C%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%C%.%#/vendor/rails/%.%#,%C\\\ %\\\\+On\\\ line\\\ #%l\\\ of\\\ %f,%CActionView::TemplateError:\\\ compile\\\ error,%Ctest_%.%#(%.%#):%#,%C%.%#\\\ [%f:%l]:,%C\\\ \\\ \\\ \\\ [%f:%l:%.%#,%C\\\ \\\ \\\ \\\ %f:%l:%.%#,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#]:,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#,%Z%f:%l:\\\ %#%m,%Z%f:%l:,%C%m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ %m,%-G%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%-G%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%-G%.%#/vendor/rails/%.%#,%-G%.%#%\\\\d%\\\\d:%\\\\d%\\\\d:%\\\\d%\\\\d%.%#,%-G%\\\\s%#from\\\ %.%#,%f:%l:\\\ %#%m,%-G%.%#
setlocal expandtab
if &filetype != 'less'
setlocal filetype=less
endif
setlocal foldcolumn=0
set nofoldenable
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
set foldnestmax=3
setlocal foldnestmax=3
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=
set linebreak
setlocal linebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=rake
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=.,~/dev/ruby/motoex,~/dev/ruby/motoex/app,~/dev/ruby/motoex/app/models,~/dev/ruby/motoex/app/controllers,~/dev/ruby/motoex/app/helpers,~/dev/ruby/motoex/config,~/dev/ruby/motoex/lib,~/dev/ruby/motoex/app/views,~/dev/ruby/motoex/test,~/dev/ruby/motoex/test/unit,~/dev/ruby/motoex/test/functional,~/dev/ruby/motoex/test/integration,~/dev/ruby/motoex/spec,~/dev/ruby/motoex/spec/models,~/dev/ruby/motoex/spec/controllers,~/dev/ruby/motoex/spec/helpers,~/dev/ruby/motoex/spec/views,~/dev/ruby/motoex/spec/lib,~/dev/ruby/motoex/app/*,~/dev/ruby/motoex/vendor,~/dev/ruby/motoex/vendor/plugins/*/lib,~/dev/ruby/motoex/vendor/plugins/*/test,~/dev/ruby/motoex/vendor/rails/*/lib,~/dev/ruby/motoex/vendor/rails/*/test
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%f%#warningmsg#%{&ff!='unix'?'['.&ff.']':''}%*%#warningmsg#%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}%*%h%y%{RailsStatusline()}%r%m%#error#%{StatuslineTabWarning()}%*%{StatuslineTrailingSpaceWarning()}%{StatuslineLongLineWarning()}%#warningmsg#%{SyntasticStatuslineFlag()}%*%#error#%{&paste?'[paste]':''}%*%=%{StatuslineCurrentHighlight()}\ \ %c,%l/%L\ %P
setlocal suffixesadd=.rb,.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.css,.js,.yml,.csv,.rake,.sql,.html,.xml
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'less'
setlocal syntax=less
endif
setlocal tabstop=8
setlocal tags=~/dev/ruby/motoex/tmp/tags,./tags,./TAGS,tags,TAGS,~/dev/ruby/motoex/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 103 - ((22 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
103
normal! 017l
wincmd w
argglobal
edit app/stylesheets/style.less
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=%D(in\\\ %f),%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Failure:,%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Error:,%+A'%.%#'\\\ FAILED,%C%.%#(eval)%.%#,%C-e:%.%#,%C%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%C%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%C%.%#/vendor/rails/%.%#,%C\\\ %\\\\+On\\\ line\\\ #%l\\\ of\\\ %f,%CActionView::TemplateError:\\\ compile\\\ error,%Ctest_%.%#(%.%#):%#,%C%.%#\\\ [%f:%l]:,%C\\\ \\\ \\\ \\\ [%f:%l:%.%#,%C\\\ \\\ \\\ \\\ %f:%l:%.%#,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#]:,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#,%Z%f:%l:\\\ %#%m,%Z%f:%l:,%C%m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ %m,%-G%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%-G%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%-G%.%#/vendor/rails/%.%#,%-G%.%#%\\\\d%\\\\d:%\\\\d%\\\\d:%\\\\d%\\\\d%.%#,%-G%\\\\s%#from\\\ %.%#,%f:%l:\\\ %#%m,%-G%.%#
setlocal expandtab
if &filetype != 'less'
setlocal filetype=less
endif
setlocal foldcolumn=0
set nofoldenable
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
set foldnestmax=3
setlocal foldnestmax=3
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=
set linebreak
setlocal linebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=rake
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=.,~/dev/ruby/motoex,~/dev/ruby/motoex/app,~/dev/ruby/motoex/app/models,~/dev/ruby/motoex/app/controllers,~/dev/ruby/motoex/app/helpers,~/dev/ruby/motoex/config,~/dev/ruby/motoex/lib,~/dev/ruby/motoex/app/views,~/dev/ruby/motoex/test,~/dev/ruby/motoex/test/unit,~/dev/ruby/motoex/test/functional,~/dev/ruby/motoex/test/integration,~/dev/ruby/motoex/spec,~/dev/ruby/motoex/spec/models,~/dev/ruby/motoex/spec/controllers,~/dev/ruby/motoex/spec/helpers,~/dev/ruby/motoex/spec/views,~/dev/ruby/motoex/spec/lib,~/dev/ruby/motoex/app/*,~/dev/ruby/motoex/vendor,~/dev/ruby/motoex/vendor/plugins/*/lib,~/dev/ruby/motoex/vendor/plugins/*/test,~/dev/ruby/motoex/vendor/rails/*/lib,~/dev/ruby/motoex/vendor/rails/*/test
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%f%#warningmsg#%{&ff!='unix'?'['.&ff.']':''}%*%#warningmsg#%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}%*%h%y%{RailsStatusline()}%r%m%#error#%{StatuslineTabWarning()}%*%{StatuslineTrailingSpaceWarning()}%{StatuslineLongLineWarning()}%#warningmsg#%{SyntasticStatuslineFlag()}%*%#error#%{&paste?'[paste]':''}%*%=%{StatuslineCurrentHighlight()}\ \ %c,%l/%L\ %P
setlocal suffixesadd=.rb,.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.css,.js,.yml,.csv,.rake,.sql,.html,.xml
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'less'
setlocal syntax=less
endif
setlocal tabstop=8
setlocal tags=~/dev/ruby/motoex/tmp/tags,./tags,./TAGS,tags,TAGS,~/dev/ruby/motoex/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 103 - ((22 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
103
normal! 017l
wincmd w
exe 'vert 1resize ' . ((&columns * 103 + 103) / 206)
exe 'vert 2resize ' . ((&columns * 102 + 103) / 206)
tabedit config/routes.rb
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 103 + 103) / 206)
exe 'vert 2resize ' . ((&columns * 102 + 103) / 206)
argglobal
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=RubyBalloonexpr()
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=^\\s*def\\s\\+\\(self\\.\\)\\=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
setlocal foldcolumn=0
set nofoldenable
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
set foldnestmax=3
setlocal foldnestmax=3
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=GetRubyIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,=end,=elsif,=when,=ensure,=rescue,==begin,==end
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=ri\ -T
set linebreak
setlocal linebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,~/dev/ruby/motoex,~/dev/ruby/motoex/app,~/dev/ruby/motoex/app/models,~/dev/ruby/motoex/app/controllers,~/dev/ruby/motoex/app/helpers,~/dev/ruby/motoex/config,~/dev/ruby/motoex/lib,~/dev/ruby/motoex/app/views,~/dev/ruby/motoex/test,~/dev/ruby/motoex/test/unit,~/dev/ruby/motoex/test/functional,~/dev/ruby/motoex/test/integration,~/dev/ruby/motoex/spec,~/dev/ruby/motoex/spec/models,~/dev/ruby/motoex/spec/controllers,~/dev/ruby/motoex/spec/helpers,~/dev/ruby/motoex/spec/views,~/dev/ruby/motoex/spec/lib,~/dev/ruby/motoex/app/*,~/dev/ruby/motoex/vendor,~/dev/ruby/motoex/vendor/plugins/*/lib,~/dev/ruby/motoex/vendor/plugins/*/test,~/dev/ruby/motoex/vendor/rails/*/lib,~/dev/ruby/motoex/vendor/rails/*/test,/usr/lib/ruby/gems/1.8/gems/gemcutter-0.1.3/lib,/usr/local/lib/site_ruby/1.8,/usr/local/lib/site_ruby/1.8/x86_64-linux,/usr/local/lib/site_ruby,/usr/lib/ruby/vendor_ruby/1.8,/usr/lib/ruby/vendor_ruby/1.8/x86_64-linux,/usr/lib/ruby/vendor_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/x86_64-linux,,~/.gem/ruby/1.8/gems/parseexcel-0.5.2/lib,/usr/lib/ruby/gems/1.8/gems/GData-0.0.4/lib,/usr/lib/ruby/gems/1.8/gems/RubyInline-3.8.3/lib,/usr/lib/ruby/gems/1.8/gems/Selenium-1.1.14/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.4/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/addressable-2.1.0/lib,/usr/lib/ruby/gems/1.8/gems/authlogic-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/binarylogic-authlogic-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/binarylogic-searchlogic-2.3.5/lib,/usr/lib/ruby/gems/1.8/gems/bind-0.2.8/lib,/usr/lib/ruby/gems/1.8/gems/builder-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/cgi_multipart_eof_fix-2.5.0/lib,/usr/lib/ruby/gems/1.8/gems/cheat-1.2.1/lib,/usr/lib/ruby/gems/1.8/gems/columnize-0.3.1/lib,/usr/lib/ruby/gems/1.8/gems/commander-4.0.0/lib,/usr/lib/ruby/gems/1.8/gems/cucumber-0.3.104/lib,/usr/lib/ruby/gems/1.8/gems/daemons-1.0.10/lib,/usr/lib/ruby/gems/1.8/gems/datamapper-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/diff-lcs-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/dm-aggregates-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-constraints-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-core-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-migrations-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-serializer-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-timestamps-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-types-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-validations-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/extlib-0.9.13/lib,/usr/lib/ruby/gems/1.8/gems/factory_girl-1.2.3/lib,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.7/ext,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.7/lib,/usr/lib/ruby/gems/1.8/gems/gem_plugin-0.2.3/lib,/usr/lib/ruby/gems/1.8/gems/gemcutter-0.1.3/lib,/usr/lib/ruby/gems/1.8/gems/haml-2.2.6/lib,/usr/lib/ruby/gems/1.8/gems/highline-1.5.1/lib,/usr/lib/ruby/gems/1.8/gems/hirb-0.2.6/lib,/usr/lib/ruby/gems/1.8/gems/hoe-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/hpricot-0.8.1/lib,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/ext,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/ext/json/ext,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/lib,/usr/lib/ruby/gems/1.8/gems/json_pure-1.1.9/lib,/usr/lib/ruby/gems/1.8/gems/jspec-2.11.10/lib,/usr/lib/ruby/gems/1.8/gems/justinfrench-formtastic-0.2.4/lib,/usr/lib/ruby/gems/1.8/gems/less-1.1.13/lib,/usr/lib/ruby/gems/1.8/gems/libxml-ruby-1.1.3/ext/libxml,/usr/lib/ruby/gems/1.8/gems/libxml-ruby-1.1.3/lib,/usr/lib/ruby/gems/1.8/gems/linecache-0.43/lib,/usr/lib/ruby/gems/1.8/gems/macaddr-1.0.0/lib,/usr/lib/ruby/gems/1.8/gems/mislav-will_paginate-2.3.11/lib,/usr/lib/ruby/gems/1.8/gems/mocha-0.9.8/lib,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/ext,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/lib,/usr/lib/ruby/gems/1.8/gems/net-scp-1.0.2/lib,/usr/lib/ruby/gems/1.8/gems/net-ssh-2.0.15/lib,/usr/lib/ruby/gems/1.8/gems/nokogiri-1.3.3/ext,/usr/lib/ruby/gems/1.8/gems/nokogiri-1.3.3/lib,/usr/lib/ruby/gems/1.8/gems/paperclip-2.3.1.1/lib,/usr/lib
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%f%#warningmsg#%{&ff!='unix'?'['.&ff.']':''}%*%#warningmsg#%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}%*%h%y%{RailsStatusline()}%r%m%#error#%{StatuslineTabWarning()}%*%{StatuslineTrailingSpaceWarning()}%{StatuslineLongLineWarning()}%#warningmsg#%{SyntasticStatuslineFlag()}%*%#error#%{&paste?'[paste]':''}%*%=%{StatuslineCurrentHighlight()}\ \ %c,%l/%L\ %P
setlocal suffixesadd=.rb,.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.yml,.csv,.rake,s.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=8
setlocal tags=~/dev/ruby/motoex/tmp/tags,./tags,./TAGS,tags,TAGS,~/dev/ruby/motoex/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 20 - ((19 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
20
normal! 024l
wincmd w
argglobal
edit app/views/layouts/application.html.erb
let s:cpo_save=&cpo
set cpo&vim
imap <buffer> <SNR>29_allmlOclose  ><Left><Left>
inoremap <buffer> <SNR>29_allmlOopen <%= 
inoremap <buffer> <SNR>29_xhtmltrans <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
inoremap <buffer> <SNR>29_htmltrans <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> \dxx <Plug>allmlLineXmlDecode
nmap <buffer> \exx <Plug>allmlLineXmlEncode
nmap <buffer> \duu <Plug>allmlLineUrlDecode
nmap <buffer> \euu <Plug>allmlLineUrlEncode
map <buffer> \dx <Plug>allmlXmlDecode
map <buffer> \ex <Plug>allmlXmlEncode
map <buffer> \du <Plug>allmlUrlDecode
map <buffer> \eu <Plug>allmlUrlEncode
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
imap <buffer> & <Plug>allmlXmlV
imap <buffer> % <Plug>allmlUrlV
imap <buffer> & <Plug>allmlXmlEncode
imap <buffer> % <Plug>allmlUrlEncode
imap <buffer> " <NL>I<# A >F<NL>s
imap <buffer> ' <#  >2hi
inoremap <buffer> _ <NL>I<% A -%>F<NL>s
inoremap <buffer> - <%  -%>3hi
imap <buffer> ] <>O
inoremap <buffer> > %>
inoremap <buffer> < <%
imap <buffer>  /
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=RubyBalloonexpr()
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=:#
setlocal commentstring=<%#%s%>
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'eruby'
setlocal filetype=eruby
endif
setlocal foldcolumn=0
set nofoldenable
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
set foldnestmax=3
setlocal foldnestmax=3
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=GetErubyIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=ri\ -T
set linebreak
setlocal linebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,~/dev/ruby/motoex,~/dev/ruby/motoex/app,~/dev/ruby/motoex/app/models,~/dev/ruby/motoex/app/controllers,~/dev/ruby/motoex/app/helpers,~/dev/ruby/motoex/config,~/dev/ruby/motoex/lib,~/dev/ruby/motoex/app/views,~/dev/ruby/motoex/app/views/application,~/dev/ruby/motoex/public,~/dev/ruby/motoex/test,~/dev/ruby/motoex/test/unit,~/dev/ruby/motoex/test/functional,~/dev/ruby/motoex/test/integration,~/dev/ruby/motoex/spec,~/dev/ruby/motoex/spec/models,~/dev/ruby/motoex/spec/controllers,~/dev/ruby/motoex/spec/helpers,~/dev/ruby/motoex/spec/views,~/dev/ruby/motoex/spec/lib,~/dev/ruby/motoex/app/*,~/dev/ruby/motoex/vendor,~/dev/ruby/motoex/vendor/plugins/*/lib,~/dev/ruby/motoex/vendor/plugins/*/test,~/dev/ruby/motoex/vendor/rails/*/lib,~/dev/ruby/motoex/vendor/rails/*/test,/usr/lib/ruby/gems/1.8/gems/gemcutter-0.1.3/lib,/usr/local/lib/site_ruby/1.8,/usr/local/lib/site_ruby/1.8/x86_64-linux,/usr/local/lib/site_ruby,/usr/lib/ruby/vendor_ruby/1.8,/usr/lib/ruby/vendor_ruby/1.8/x86_64-linux,/usr/lib/ruby/vendor_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/x86_64-linux,,~/.gem/ruby/1.8/gems/parseexcel-0.5.2/lib,/usr/lib/ruby/gems/1.8/gems/GData-0.0.4/lib,/usr/lib/ruby/gems/1.8/gems/RubyInline-3.8.3/lib,/usr/lib/ruby/gems/1.8/gems/Selenium-1.1.14/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.4/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/addressable-2.1.0/lib,/usr/lib/ruby/gems/1.8/gems/authlogic-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/binarylogic-authlogic-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/binarylogic-searchlogic-2.3.5/lib,/usr/lib/ruby/gems/1.8/gems/bind-0.2.8/lib,/usr/lib/ruby/gems/1.8/gems/builder-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/cgi_multipart_eof_fix-2.5.0/lib,/usr/lib/ruby/gems/1.8/gems/cheat-1.2.1/lib,/usr/lib/ruby/gems/1.8/gems/columnize-0.3.1/lib,/usr/lib/ruby/gems/1.8/gems/commander-4.0.0/lib,/usr/lib/ruby/gems/1.8/gems/cucumber-0.3.104/lib,/usr/lib/ruby/gems/1.8/gems/daemons-1.0.10/lib,/usr/lib/ruby/gems/1.8/gems/datamapper-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/diff-lcs-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/dm-aggregates-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-constraints-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-core-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-migrations-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-serializer-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-timestamps-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-types-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/dm-validations-0.10.1/lib,/usr/lib/ruby/gems/1.8/gems/extlib-0.9.13/lib,/usr/lib/ruby/gems/1.8/gems/factory_girl-1.2.3/lib,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.7/ext,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.7/lib,/usr/lib/ruby/gems/1.8/gems/gem_plugin-0.2.3/lib,/usr/lib/ruby/gems/1.8/gems/gemcutter-0.1.3/lib,/usr/lib/ruby/gems/1.8/gems/haml-2.2.6/lib,/usr/lib/ruby/gems/1.8/gems/highline-1.5.1/lib,/usr/lib/ruby/gems/1.8/gems/hirb-0.2.6/lib,/usr/lib/ruby/gems/1.8/gems/hoe-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/hpricot-0.8.1/lib,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/ext,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/ext/json/ext,/usr/lib/ruby/gems/1.8/gems/json-1.1.9/lib,/usr/lib/ruby/gems/1.8/gems/json_pure-1.1.9/lib,/usr/lib/ruby/gems/1.8/gems/jspec-2.11.10/lib,/usr/lib/ruby/gems/1.8/gems/justinfrench-formtastic-0.2.4/lib,/usr/lib/ruby/gems/1.8/gems/less-1.1.13/lib,/usr/lib/ruby/gems/1.8/gems/libxml-ruby-1.1.3/ext/libxml,/usr/lib/ruby/gems/1.8/gems/libxml-ruby-1.1.3/lib,/usr/lib/ruby/gems/1.8/gems/linecache-0.43/lib,/usr/lib/ruby/gems/1.8/gems/macaddr-1.0.0/lib,/usr/lib/ruby/gems/1.8/gems/mislav-will_paginate-2.3.11/lib,/usr/lib/ruby/gems/1.8/gems/mocha-0.9.8/lib,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/ext,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/lib,/usr/lib/ruby/gems/1.8/gems/net-scp-1.0.2/lib,/usr/lib/ruby/gems/1.8/gems/net-ssh-2.0.15/lib,/usr/lib/ruby/gems/1.8/gems/nokogiri-1.3.3/ext,/usr/lib/ruby/gems/1.8/gems/nokogiri-1.3
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%f%#warningmsg#%{&ff!='unix'?'['.&ff.']':''}%*%#warningmsg#%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}%*%h%y%{RailsStatusline()}%r%m%#error#%{StatuslineTabWarning()}%*%{StatuslineTrailingSpaceWarning()}%{StatuslineLongLineWarning()}%#warningmsg#%{SyntasticStatuslineFlag()}%*%#error#%{&paste?'[paste]':''}%*%=%{StatuslineCurrentHighlight()}\ \ %c,%l/%L\ %P
setlocal suffixesadd=.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.rb,.css,.js,.html,.yml,.csv
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'eruby'
setlocal syntax=eruby
endif
setlocal tabstop=8
setlocal tags=~/dev/ruby/motoex/tmp/tags,./tags,./TAGS,tags,TAGS,~/dev/ruby/motoex/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 15 - ((14 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
15
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 103 + 103) / 206)
exe 'vert 2resize ' . ((&columns * 102 + 103) / 206)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
