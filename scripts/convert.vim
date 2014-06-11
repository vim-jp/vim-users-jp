scriptencoding utf-8

" Usage:
"  1. Goto the project root.
"  2. Open this script. (vim script/convert.vim)
"  3. :so %
"
" Dependency:
"  https://github.com/mattn/webapi-vim

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
  let text = substitute(text, '\vhttp://vim-users.jp/wp-content/uploads/', '/vim-users-jp/assets/images/', 'g')
  let text = substitute(text, '\vhttp://vim-users.jp/', '/vim-users-jp/', 'g')
  let text = substitute(text, '\vhttp://vim-users.jp', '/vim-users-jp/', 'g')
  let text = substitute(text, 'http://lingr.vim-users.jp/\?', 'http://lingr.com/room/vim', 'g')
  let text = substitute(text, '>\([a-z]\+\).vim-users.jp<', '><del>\1.vim-users.jp</del><', 'g')
  let text = substitute(text, '\vhttp://vim-users.jp/vim-users-jp-official-lingr-chat-room/', 'http://lingr.com/room/vim', 'g')
  let text = substitute(text, '\vhttp://rst.gsfc.nasa.gov/Sect16/full-20earth2.jpg', 'http://vaidehiparikh.files.wordpress.com/2012/08/full-20earth2.jpg', 'g')
  let text = substitute(text, '/web/[0-9]\+/', '', 'g')
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
