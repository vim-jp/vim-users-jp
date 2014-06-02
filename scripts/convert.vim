scriptencoding utf-8

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
  throw "error!: " . a:f
endfunction

function! s:trim(line) abort
  return substitute(substitute(a:line, '^\s\+', '', 'g'), '\s\+$', '', 'g')
endfunction

function! s:text(f, lines) abort
  let intext = 0
  let text = ''
  for line in a:lines
    if stridx(line, 'wp_social_bookmarking_light') >= 0
      return join(map(split(text, "\n"), 's:trim(v:val)'), "\n")
    endif
    if intext
      let text .= line . "\n"
    elseif stridx(line, '<div class="textBody">') >= 0
      let intext = 1
    endif
  endfor
  throw "error!: " . a:f
endfunction

function! s:index(lines, str) abort
  for i in range(len(a:lines))
    if stridx(a:lines[i], a:str) >= 0
      return i
    endif
  endfor
  return -1
endfunction

function! s:convert(f) abort
  let lines = map(readfile(a:f), 'substitute(iconv(v:val,"utf-8",&encoding), "\n", "", "g")')
  let pos1 = s:index(lines, '<h1>')
  let pos2 = s:index(lines, '</div><!--end entry-->')
  if pos1 < 0 || pos2 < 0
    throw "error!: " . a:f
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
  let text = substitute(text, 'src="http://vim-users.jp/wp-content/uploads/', '/vim-users-jp/assets/images/', 'g')
  let text = substitute(text, 'http://vim-users.jp/vim-users-jp-official-lingr-chat-room/', 'http://lingr.com/room/vim', 'g')
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
  "if short =~ '^Hack-[0-9]\+'
  "  let short = matchstr(short, 'Hack-[0-9]\+')
  "endif
  let fname = "_posts/" . date . "-" . short . ".html"
  let fname = substitute(fname, '--*', '-', "g")
  let fname = substitute(fname, '-\.html$', '.html', "g")
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
  call writefile(map(lines, 'iconv(v:val, &encoding, "utf-8")'), fname)
endfunction

function! s:scan() abort
  for f in split(glob("_posts/*.html"), "\n")
    call delete(f)
  endfor
  for f in split(glob("_original/index.html*"), "\n")
    call s:convert(f)
  endfor
endfunction

call s:scan()
