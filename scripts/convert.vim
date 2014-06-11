scriptencoding utf-8

" Usage:
"  1. Goto the project root.
"  2. Open this script. (vim script/convert.vim)
"  3. :so %
"
" Dependency:
"  https://github.com/mattn/webapi-vim

let s:urlmap = {
\  "/vim-users-jp/2009/03/mtl_vim/": "/vim-users-jp/2009/03/mtl-vim.html",
\  "/vim-users-jp/2009/04/hack2/": "/vim-users-jp/2009/04/Hack-2.html",
\  "/vim-users-jp/2009/04/hack3/": "/vim-users-jp/2009/04/Hack-3.html",
\  "/vim-users-jp/2009/05/hack11/": "/vim-users-jp/2009/05/Hack-11.html",
\  "/vim-users-jp/2009/05/hack12/": "/vim-users-jp/2009/05/Hack-12.html",
\  "/vim-users-jp/2009/05/hack13/": "/vim-users-jp/2009/05/Hack-13.html",
\  "/vim-users-jp/2009/05/hack15/": "/vim-users-jp/2009/05/Hack-15.html",
\  "/vim-users-jp/2009/05/hack18/": "/vim-users-jp/2009/05/Hack-18.html",
\  "/vim-users-jp/2009/05/hack4/": "/vim-users-jp/2009/05/Hack-4.html",
\  "/vim-users-jp/2009/05/hack5/": "/vim-users-jp/2009/05/Hack-5.html",
\  "/vim-users-jp/2009/05/hack7/": "/vim-users-jp/2009/05/Hack-7.html",
\  "/vim-users-jp/2009/05/hack8/": "/vim-users-jp/2009/05/Hack-8.html",
\  "/vim-users-jp/2009/06/blogger-vim-talk-with-ujihisa-on-vimm4/": "/vim-users-jp/2009/06/blogger-vim-talk-with-ujihisa-on-vimm4.html",
\  "/vim-users-jp/2009/06/hack20/": "/vim-users-jp/2009/06/Hack-20.html",
\  "/vim-users-jp/2009/06/hack21/": "/vim-users-jp/2009/06/Hack-21.html",
\  "/vim-users-jp/2009/06/hack23/": "/vim-users-jp/2009/06/Hack-23.html",
\  "/vim-users-jp/2009/06/hack26/": "/vim-users-jp/2009/06/Hack-26.html",
\  "/vim-users-jp/2009/06/hack30/": "/vim-users-jp/2009/06/Hack-30.html",
\  "/vim-users-jp/2009/06/vimm4-ann/": "/vim-users-jp/2009/06/vimm4-ann.html",
\  "/vim-users-jp/2009/07/hack-44/": "/vim-users-jp/2009/07/Hack-44.html",
\  "/vim-users-jp/2009/07/hack-49/": "/vim-users-jp/2009/07/Hack-49.html",
\  "/vim-users-jp/2009/07/hack35/": "/vim-users-jp/2009/07/Hack-35.html",
\  "/vim-users-jp/2009/07/hack36/": "/vim-users-jp/2009/07/Hack-36.html",
\  "/vim-users-jp/2009/07/hack37/": "/vim-users-jp/2009/07/Hack-37.html",
\  "/vim-users-jp/2009/07/hack43/": "/vim-users-jp/2009/07/Hack-43.html",
\  "/vim-users-jp/2009/07/hack45/": "/vim-users-jp/2009/07/Hack-45.html",
\  "/vim-users-jp/2009/08/hack-59/": "/vim-users-jp/2009/08/Hack-59.html",
\  "/vim-users-jp/2009/08/hack51/": "/vim-users-jp/2009/08/Hack-51.html",
\  "/vim-users-jp/2009/08/hack52/": "/vim-users-jp/2009/08/Hack-52.html",
\  "/vim-users-jp/2009/08/hack55/": "/vim-users-jp/2009/08/Hack-55.html",
\  "/vim-users-jp/2009/08/hack64/": "/vim-users-jp/2009/08/Hack-64.html",
\  "/vim-users-jp/2009/09/hack67/": "/vim-users-jp/2009/09/Hack-67.html",
\  "/vim-users-jp/2009/09/hack70/": "/vim-users-jp/2009/09/Hack-70.html",
\  "/vim-users-jp/2009/09/hack71/": "/vim-users-jp/2009/09/Hack-71.html",
\  "/vim-users-jp/2009/09/hack72/": "/vim-users-jp/2009/09/Hack-72.html",
\  "/vim-users-jp/2009/09/hack76/": "/vim-users-jp/2009/09/Hack-76.html",
\  "/vim-users-jp/2009/09/hack77/": "/vim-users-jp/2009/09/Hack-77.html",
\  "/vim-users-jp/2009/09/hack80/": "/vim-users-jp/2009/09/Hack-80.html",
\  "/vim-users-jp/2009/10/hack92/": "/vim-users-jp/2009/10/Hack-92.html",
\  "/vim-users-jp/2009/11/hack100/": "/vim-users-jp/2009/11/Hack-100.html",
\  "/vim-users-jp/2009/11/hack100/#fn:1": "/vim-users-jp/2009/11/hack100/#fn:1",
\  "/vim-users-jp/2009/11/hack100/#fnref:1": "/vim-users-jp/2009/11/hack100/#fnref:1",
\  "/vim-users-jp/2009/11/hack104/": "/vim-users-jp/2009/11/Hack-104.html",
\  "/vim-users-jp/2009/11/hack105/": "/vim-users-jp/2009/11/Hack-105.html",
\  "/vim-users-jp/2009/12/hack112/": "/vim-users-jp/2009/12/Hack-112.html",
\  "/vim-users-jp/2010/01/vimworkshop5-ujihisa/": "/vim-users-jp/2010/01/Vimworkshop5-ujihisa.html",
\  "/vim-users-jp/2010/02/hack125/": "/vim-users-jp/2010/02/Hack-125.html",
\  "/vim-users-jp/2010/03/hack129/": "/vim-users-jp/2010/03/Hack-129.html",
\  "/vim-users-jp/2010/03/hack131/": "/vim-users-jp/2010/03/Hack-131.html",
\  "/vim-users-jp/2010/03/hack132/": "/vim-users-jp/2010/03/Hack-132.html",
\  "/vim-users-jp/2010/03/hack134/": "/vim-users-jp/2010/03/Hack-134.html",
\  "/vim-users-jp/2010/04/hack142/": "/vim-users-jp/2010/04/Hack-142.html",
\  "/vim-users-jp/2010/07/hack160/": "/vim-users-jp/2010/07/Hack-160.html",
\  "/vim-users-jp/2010/07/hack161/": "/vim-users-jp/2010/07/Hack-161.html",
\  "/vim-users-jp/2010/07/hack162/": "/vim-users-jp/2010/07/Hack-162.html",
\  "/vim-users-jp/2010/07/hack164/": "/vim-users-jp/2010/07/Hack-164.html",
\  "/vim-users-jp/2010/08/hack170/": "/vim-users-jp/2010/08/Hack-170.html",
\  "/vim-users-jp/2010/09/hack172/": "/vim-users-jp/2010/09/Hack-172.html",
\  "/vim-users-jp/2010/09/quickquine/": "/vim-users-jp/2010/09/quick-quine.html",
\  "/vim-users-jp/2010/10/hack176/": "/vim-users-jp/2010/10/Hack-176.html",
\  "/vim-users-jp/2010/10/hack178/": "/vim-users-jp/2010/10/Hack-178.html",
\  "/vim-users-jp/2010/12/hack186/": "/vim-users-jp/2010/12/Hack-186.html",
\  "/vim-users-jp/2010/12/hack188/": "/vim-users-jp/2010/12/Hack-188.html",
\  "/vim-users-jp/2010/12/hack189/": "/vim-users-jp/2010/12/Hack-189.html",
\  "/vim-users-jp/2011/01/hack196/": "/vim-users-jp/2011/01/Hack-196.html",
\  "/vim-users-jp/2011/01/hack197/": "/vim-users-jp/2011/01/Hack-197.html",
\  "/vim-users-jp/2011/02/hack199/": "/vim-users-jp/2011/02/Hack-199.html",
\  "/vim-users-jp/2011/02/hack200/": "/vim-users-jp/2011/02/Hack-200.html",
\  "/vim-users-jp/2011/04/hack211/": "/vim-users-jp/2011/04/Hack-211.html",
\  "/vim-users-jp/2011/04/hack215/": "/vim-users-jp/2011/04/Hack-215.html",
\  "/vim-users-jp/2011/07/release-note-quickrun-05/": "/vim-users-jp/2011/07/Release-Note-Quickrun-05.html",
\  "/vim-users-jp/2011/09/hack229/": "/vim-users-jp/2011/09/Hack-229.html",
\  "/vim-users-jp/2011/10/hack235/": "/vim-users-jp/2011/10/Hack-235.html",
\  "/vim-users-jp/2012/11/ujihisa-vim-3-pre-2/": "/vim-users-jp/2012/11/Ujihisa-Vim-3-Pre-2.html",
\  "/vim-users-jp/2013/03/wanted-vim-advent-calendar-2012/lingr.com/room/vim": "/vim-users-jp/2013/03/Wanted-Vim-Advent-Calendar-2012/lingr.com/room/vim",
\}

let s:fmap = {}
let s:index = []
let s:clean_dup = 0

function! s:author(f, lines) abort
  for line in a:lines
    if stridx(line, '<address class="hack-author">') >= 0
      return matchstr(line, '>\zs[^<]\+\ze<')
    endif
  endfor
  return ''
endfunction

function! s:date(f, lines) abort
  for line in a:lines
    if stridx(line, 'class="date"') >= 0
      return matchstr(line, '[0-9]\{4}-[0-9]\{2}-[0-9]\{2}')
    endif
  endfor
  throw "date parse error!: " . a:f
endfunction

function! s:trim_left_for_tag(line) abort
  return substitute(substitute(a:line, '^\s\+\ze<', '', 'g'), '\s\+$', '', 'g')
endfunction

function! s:trim(line) abort
  return substitute(substitute(a:line, '^\s\+', '', 'g'), '\s\+$', '', 'g')
endfunction

function! s:text(f, lines) abort
  let intext = 0
  let text = ''
  for line in a:lines
    if stridx(line, 'wp_social_bookmarking_light') >= 0
      return join(map(split(text, "\n"), 's:trim_left_for_tag(v:val)'), "\n")
    endif
    if intext
      let text .= line . "\n"
    elseif stridx(line, '<div class="textBody">') >= 0
      let intext = 1
    endif
  endfor
  throw "text parse error!: " . a:f
endfunction

function! s:index(lines, str) abort
  for i in range(len(a:lines))
    if stridx(a:lines[i], a:str) >= 0
      return i
    endif
  endfor
  return -1
endfunction

function! s:from_utf8(str) abort
  let str = a:str
  let m = {
  \ "\xE3\x80\x9C": "\xEF\xBD\x9E",
  \ "\xE2\x80\x93": "\xEF\xBC\x8D",
  \}
  for k in keys(m)
    let v = m[k]
    let l = len(k)
    let pos = -l
    while 1
      let pos = stridx(str, k, pos + l)
      if pos < 0
        break
      endif
      let str = strpart(str, 0, pos) . v . strpart(str, pos + l)
    endwhile
  endfor
  return iconv(str, "utf-8", &encoding)
endfunction

function! s:readfile(f)
  "if &encoding == 'cp932' && executable('nkf')
  "  silent let res = system(printf("cat %s | nkf -Wxs", a:f))
  "  return split(res, "\n")
  "endif
  return map(readfile(a:f), 'substitute(s:from_utf8(v:val), "\n", "", "g")')
endfunction

function! s:lang(str) abort
  if a:str =~# 'endfunction' || a:str =~# 'Bundle'
    return '<code class="lang-vim">' . a:str . '</code>'
  endif
  return '<code>' . a:str . '</code>'
endfunction

function! s:convert(f) abort
  let lines = s:readfile(a:f)
  let pos1 = s:index(lines, '<h1>')
  let pos2 = s:index(lines, '</div><!--end entry-->')
  if pos1 < 0 || pos2 < 0
    throw "body parse error!: " . a:f
  endif
  let lines = lines[pos1 : pos2]
  let title = matchstr(lines[0], '<h1>\zs.\+\ze</h1>')
  let date = s:date(a:f, lines)
  let author = s:author(a:f, lines)
  let text = s:text(a:f, lines)
  let text = substitute(text, '\(src\|href\)=''\([^'']\+\)''', '\1="\2"', 'g')
  let text = substitute(text, '\(src\|href\)="/web/[^"]\+/\(http://[^"]\+\)"', '\1="\2"', 'g')
  let text = substitute(text, '\(src\|href\)="/web/[^"]\+/\(https://[^"]\+\)"', '\1="\2"', 'g')
  let text = substitute(text, '{{{', '\\{\\{\\{', 'g')
  let text = substitute(text, '{{', '\\{\\{', 'g')
  let text = substitute(text, '}}}', '\\}\\}\\}', 'g')
  let text = substitute(text, '}}', '\\}\\}', 'g')
  let text = substitute(text, '\Vhttp://vim-users.jp/wp-content/uploads/', '/vim-users-jp/assets/images/', 'g')
  let text = substitute(text, '\Vhttp://vim-users.jp/', '/vim-users-jp/', 'g')
  let text = substitute(text, '\Vhttp://vim-users.jp', '/vim-users-jp/', 'g')
  let text = substitute(text, 'http://lingr.vim-users.jp/\?', 'http://lingr.com/room/vim', 'g')
  let text = substitute(text, '>\([a-z]\+\).vim-users.jp<', '><del>\1.vim-users.jp</del><', 'g')
  let text = substitute(text, '\Vhttp://vim-users.jp/vim-users-jp-official-lingr-chat-room/', 'http://lingr.com/room/vim', 'g')
  let text = substitute(text, '\Vhttp://rst.gsfc.nasa.gov/Sect16/full-20earth2.jpg', 'http://vaidehiparikh.files.wordpress.com/2012/08/full-20earth2.jpg', 'g')
  let text = substitute(text, '<code class="vim-script">', '<code class="lang-vim">', 'g')
  let text = substitute(text, '\Vもう少し:Captureについて (unite.vim)', 'unite.vimで:Capture', 'g')
  let text = substitute(text, '<pre>\s*\(<code[^>]*>.\{-}</code>\s*\)</pre>', '<pre class="prettyprint">\1</pre>', 'g')
  let text = substitute(text, '<pre>\s*\(<code[^>]*>.\{-}</code>\s*\)</pre>', '<pre class="prettyprint">\1</pre>', 'g')
  let text = substitute(text, '<code>\(.\{-}\)</code>', '\=s:lang(submatch(1))', 'g')
  let text = substitute(text, '/web/[0-9]\+/', '', 'g')
  for k in keys(s:urlmap)
    let v = s:urlmap[k]
    let l = len(k)
    let pos = -l
    while 1
      let pos = stridx(text, k, pos + l)
      if pos < 0
        break
      endif
      let text = strpart(text, 0, pos) . v . strpart(text, pos + l)
    endwhile
  endfor
  let short = title
  let dict = [
  \ ['東京都渋谷', 'tokyo-shibuya'],
  \ ['東京', 'tokyo'],
  \ ['兵庫県尼崎市', 'hyogo-amagasaki'],
  \ ['京都', 'kyoto'],
  \ ['尼崎市', 'amagasaki'],
  \ ['日本の', 'japanese'],
  \ ['新しい', 'new'],
  \ ['プロトコル', 'protocol'],
  \ ['テクニックバイブル', 'technique-bible'],
  \ ['英語', 'english'],
  \ ['お知らせ', 'ann'],
  \ ['公募', 'rtf'],
  \ ['募集', 'rtf'],
  \ ['新年あけましておめでとうございます', 'a-happy-new-year'],
  \ ['&#8212;', '-'],
  \ ['&#8220;', '-'],
  \]
  for item in dict
    let short = substitute(short, item[0], item[1], 'g')
  endfor
  let short = substitute(short, '[^a-zA-Z0-9_]\+', '-', "g")
  if short =~ '^Hack-[0-9]\+'
    let short = matchstr(short, 'Hack-[0-9]\+')
  endif
  let short = substitute(short, '--*', '-', "g")
  let short = substitute(short, '^-*', '', "g")
  let short = substitute(short, '-$', '', "g")
  let fname = "_posts/" . date . "-" . short . ".html"
  if short =~ '^Hack-[0-9]\+'
    call add(s:index, {"hack": 0+matchstr(short, '[0-9]\+'), "title":title, "date":substitute(date, '-', '/', 'g'), "url":printf("http://vim-jp.org/vim-users-jp/%s/%s.html", substitute(date, '-', '/', 'g'), short)})
  endif
  "let title = substitute(title, ': ', '', 'g')
  "let title = substitute(title, '[#\[\]]', '\="&#".char2nr(submatch(0)).";"', 'g')
  let lines = [
  \  "---",
  \  "layout: post",
  \  printf("title: \"%s\"", title),
  \  printf("date: %s", date),
  \  printf("author: %s", author),
  \  "---",
  \] + split(text, "\n")
  if s:clean_dup
    if has_key(s:fmap, fname)
      call add(s:fmap[fname], a:f)
    else
      let s:fmap[fname] = [a:f]
      call writefile(map(lines, 'iconv(v:val, &encoding, "utf-8")'), fname)
    endif
  else
    if filereadable(fname)
      throw "file duplicate error!: " . fname
    endif
    call writefile(map(lines, 'iconv(v:val, &encoding, "utf-8")'), fname)
  endif
endfunction

function! s:scan() abort
  for f in split(glob("_posts/*.html"), "\n")
    call delete(f)
  endfor
  for f in sort(split(glob("_original/http_*"), "\n"))
    try
      call s:convert(f)
    catch
      redraw
      echo v:exception
    endtry
  endfor
  if s:clean_dup
    call s:clean()
  endif
endfunction

function! s:clean()
  for fs in values(s:fmap)
    if len(fs) > 1
      let fs = sort(fs)
      for f in fs[:-2]
        call delete(f)
      endfor
    endif
  endfor
endfunction

call s:scan()

function! s:sortcmp(lhs, rhs)
  return (0+a:lhs["hack"]) > (0+a:rhs["hack"])
endfunction

call sort(s:index, 's:sortcmp')
call writefile(split(webapi#json#encode(s:index),"\n"), 'hack.json')
