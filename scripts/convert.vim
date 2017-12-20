scriptencoding utf-8

" Usage:
"  1. Goto the project root.
"  2. Open this script. (vim script/convert.vim)
"  3. :so %
"
" Dependency:
"  https://github.com/mattn/webapi-vim

let s:urlmap = {
\  '/vim-users-jp/2009/07/hack-49/': '/vim-users-jp/2009/07/30/Hack-49.html',
\  '/vim-users-jp/2009/04/hack2/': '/vim-users-jp/2009/04/27/Hack-2.html',
\  '/vim-users-jp/2009/12/hack112/': '/vim-users-jp/2009/12/27/Hack-112.html',
\  '/vim-users-jp/2009/08/hack55/': '/vim-users-jp/2009/08/11/Hack-55.html',
\  '/vim-users-jp/2010/10/hack178/': '/vim-users-jp/2010/10/23/Hack-178.html',
\  '/vim-users-jp/2009/06/hack26/': '/vim-users-jp/2009/06/14/Hack-26.html',
\  '/vim-users-jp/2010/07/hack161/': '/vim-users-jp/2010/07/14/Hack-161.html',
\  '/vim-users-jp/2009/06/hack21/': '/vim-users-jp/2009/06/04/Hack-21.html',
\  '/vim-users-jp/2009/05/hack18/': '/vim-users-jp/2009/05/29/Hack-18.html',
\  '/vim-users-jp/2009/07/hack-44/': '/vim-users-jp/2009/07/20/Hack-44.html',
\  '/vim-users-jp/2009/05/hack8/': '/vim-users-jp/2009/05/09/Hack-8.html',
\  '/vim-users-jp/2009/11/hack100/': '/vim-users-jp/2009/11/09/Hack-100.html',
\  '/vim-users-jp/2009/05/hack13/': '/vim-users-jp/2009/05/19/Hack-13.html',
\  '/vim-users-jp/2009/11/hack104/': '/vim-users-jp/2009/11/25/Hack-104.html',
\  '/vim-users-jp/2011/02/hack200/': '/vim-users-jp/2011/02/10/Hack-200.html',
\  '/vim-users-jp/2011/01/hack197/': '/vim-users-jp/2011/01/30/Hack-197.html',
\  '/vim-users-jp/2009/07/hack37/': '/vim-users-jp/2009/07/06/Hack-37.html',
\  '/vim-users-jp/2012/11/ujihisa-vim-3-pre-2/': '/vim-users-jp/2012/11/02/ujihisa-vim-3.html',
\  '/vim-users-jp/2010/10/hack176/': '/vim-users-jp/2010/10/12/Hack-176.html',
\  '/vim-users-jp/2010/01/vimworkshop5-ujihisa/': '/vim-users-jp/2010/01/31/Vim-5-ujihisa.html',
\  '/vim-users-jp/2009/07/hack45/': '/vim-users-jp/2009/07/22/Hack-45.html',
\  '/vim-users-jp/2010/07/hack164/': '/vim-users-jp/2010/07/29/Hack-164.html',
\  '/vim-users-jp/2010/08/hack170/': '/vim-users-jp/2010/08/28/Hack-170.html',
\  '/vim-users-jp/2009/09/hack77/': '/vim-users-jp/2009/09/24/Hack-77.html',
\  '/vim-users-jp/2009/09/hack72/': '/vim-users-jp/2009/09/14/Hack-72.html',
\  '/vim-users-jp/2009/05/hack11/': '/vim-users-jp/2009/05/15/Hack-11.html',
\  '/vim-users-jp/2013/03/wanted-vim-advent-calendar-2012/lingr.com/room/vim': '/vim-users-jp/2013/03/20/Vim-Advent-Calendar-2012-rtf.html',
\  '/vim-users-jp/2009/06/blogger-vim-talk-with-ujihisa-on-vimm4/': '/vim-users-jp/2009/06/23/blogger-vim-talk-with-ujihisa-on-VimM-4.html',
\  '/vim-users-jp/2009/07/hack35/': '/vim-users-jp/2009/07/02/Hack-35.html',
\  '/vim-users-jp/2010/12/hack188/': '/vim-users-jp/2010/12/12/Hack-188.html',
\  '/vim-users-jp/2010/02/hack125/': '/vim-users-jp/2010/02/17/Hack-125.html',
\  '/vim-users-jp/2009/09/hack80/': '/vim-users-jp/2009/09/30/Hack-80.html',
\  '/vim-users-jp/2009/04/hack3/': '/vim-users-jp/2009/04/29/Hack-3.html',
\  '/vim-users-jp/2010/09/quickquine/': '/vim-users-jp/2010/09/29/quickrun-quine.html',
\  '/vim-users-jp/2010/03/hack131/': '/vim-users-jp/2010/03/13/Hack-131.html',
\  '/vim-users-jp/2009/07/hack43/': '/vim-users-jp/2009/07/18/Hack-43.html',
\  '/vim-users-jp/2010/04/hack142/': '/vim-users-jp/2010/04/26/Hack-142.html',
\  '/vim-users-jp/2010/07/hack162/': '/vim-users-jp/2010/07/19/Hack-162.html',
\  '/vim-users-jp/2009/09/hack67/': '/vim-users-jp/2009/09/04/Hack-67.html',
\  '/vim-users-jp/2009/08/hack51/': '/vim-users-jp/2009/08/03/Hack-51.html',
\  '/vim-users-jp/2011/04/hack215/': '/vim-users-jp/2011/04/30/Hack-215.html',
\  '/vim-users-jp/2009/06/hack30/': '/vim-users-jp/2009/06/22/Hack-30.html',
\  '/vim-users-jp/2009/11/hack105/': '/vim-users-jp/2009/11/29/Hack-105.html',
\  '/vim-users-jp/2009/05/hack4/': '/vim-users-jp/2009/05/01/Hack-4.html',
\  '/vim-users-jp/2011/07/release-note-quickrun-05/': '/vim-users-jp/2011/07/27/quickrun-0-5-0.html',
\  '/vim-users-jp/2009/09/hack70/': '/vim-users-jp/2009/09/10/Hack-70.html',
\  '/vim-users-jp/2009/08/hack-59/': '/vim-users-jp/2009/08/19/Hack-59.html',
\  '/vim-users-jp/2010/12/hack186/': '/vim-users-jp/2010/12/02/Hack-186.html',
\  '/vim-users-jp/2009/09/hack71/': '/vim-users-jp/2009/09/12/Hack-71.html',
\  '/vim-users-jp/2010/03/hack134/': '/vim-users-jp/2010/03/25/Hack-134.html',
\  '/vim-users-jp/2010/07/hack160/': '/vim-users-jp/2010/07/07/Hack-160.html',
\  '/vim-users-jp/2009/06/hack20/': '/vim-users-jp/2009/06/02/Hack-20.html',
\  '/vim-users-jp/2009/08/hack64/': '/vim-users-jp/2009/08/29/Hack-64.html',
\  '/vim-users-jp/2011/02/hack199/': '/vim-users-jp/2011/02/05/Hack-199.html',
\  '/vim-users-jp/2009/05/hack7/': '/vim-users-jp/2009/05/07/Hack-7.html',
\  '/vim-users-jp/2010/03/hack129/': '/vim-users-jp/2010/03/05/Hack-129.html',
\  '/vim-users-jp/2009/05/hack12/': '/vim-users-jp/2009/05/17/Hack-12.html',
\  '/vim-users-jp/2011/01/hack196/': '/vim-users-jp/2011/01/21/Hack-196.html',
\  '/vim-users-jp/2009/08/hack52/': '/vim-users-jp/2009/08/05/Hack-52.html',
\  '/vim-users-jp/2009/07/hack36/': '/vim-users-jp/2009/07/04/Hack-36.html',
\  '/vim-users-jp/2010/12/hack189/': '/vim-users-jp/2010/12/17/Hack-189.html',
\  '/vim-users-jp/2011/09/hack229/': '/vim-users-jp/2011/09/15/Hack-229.html',
\  '/vim-users-jp/2010/03/hack132/': '/vim-users-jp/2010/03/17/Hack-132.html',
\  '/vim-users-jp/2010/09/hack172/': '/vim-users-jp/2010/09/07/Hack-172.html',
\  '/vim-users-jp/2009/06/vimm4-ann/': '/vim-users-jp/2009/06/11/vimm-4-ann.html',
\  '/vim-users-jp/2011/10/hack235/': '/vim-users-jp/2011/10/10/Hack-235.html',
\  '/vim-users-jp/2009/06/hack23/': '/vim-users-jp/2009/06/08/Hack-23.html',
\  '/vim-users-jp/2009/10/hack92/': '/vim-users-jp/2009/10/24/Hack-92.html',
\  '/vim-users-jp/2009/09/hack76/': '/vim-users-jp/2009/09/22/Hack-76.html',
\  '/vim-users-jp/2009/05/hack15/': '/vim-users-jp/2009/05/23/Hack-15.html',
\  '/vim-users-jp/2011/04/hack211/': '/vim-users-jp/2011/04/06/Hack-211.html',
\  '/vim-users-jp/2009/05/hack5/': '/vim-users-jp/2009/05/03/Hack-5.html',
\  '/vim-users-jp/2009/03/mtl_vim/': '/vim-users-jp/2009/03/30/MTL-Vim.html',
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
  \ "\xE3\x80\x9C": "&#12316;",
  \ "\xE2\x80\x93": "&#8211;",
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

let s:langmap = {
\  '\<endfunction\>\|\<Bundle\>\|\<NeoBundle\>\|\<nnoremap\>\|\<augroup\>\|\<autocmd\>\|\<cursorcolumn\>\|:highlight\|:silent': 'lang-vim',
\  '^set ': 'lang-vim',
\  '^:': 'lang-vim',
\}

function! s:html_escape(str)
  let str = a:str
  let str = substitute(str, '<', '\&lt;', 'g')
  let str = substitute(str, '>', '\&gt;', 'g')
endfunction

function! s:pre(str) abort
  return '<pre class="prettyprint">' . s:code(a:str) . '</pre>'
endfunction

function! s:code(str) abort
  for k in keys(s:langmap)
    if a:str =~# k
      return '<code class="' . s:langmap[k] . '">' . s:html_escape(a:str) . '</code>'
    endif
  endfor
  return '<code>' . s:html_escape(a:str) . '</code>'
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
  let text = substitute(text, '{{{', '\&#123;\&#123;\&#123;', 'g')
  let text = substitute(text, '{{', '\&#123;\&#123;', 'g')
  let text = substitute(text, '}}}', '\&#125;\&#125;\&#125;', 'g')
  let text = substitute(text, '}}', '\&#125;\&#125;', 'g')
  let text = substitute(text, '\Vhttp://vim-users.jp/wp-content/uploads/', '/vim-users-jp/assets/images/', 'g')
  let text = substitute(text, '\Vhttp://vim-users.jp/', '/vim-users-jp/', 'g')
  let text = substitute(text, '\Vhttp://vim-users.jp', '/vim-users-jp/', 'g')
  let text = substitute(text, 'http://lingr.vim-users.jp/\?', 'http://lingr.com/room/vim', 'g')
  let text = substitute(text, '>\([a-z]\+\).vim-users.jp<', '><del>\1.vim-users.jp</del><', 'g')
  let text = substitute(text, '\Vhttp://vim-users.jp/vim-users-jp-official-lingr-chat-room/', 'http://lingr.com/room/vim', 'g')
  let text = substitute(text, '\Vhttp://rst.gsfc.nasa.gov/Sect16/full-20earth2.jpg', 'http://vaidehiparikh.files.wordpress.com/2012/08/full-20earth2.jpg', 'g')
  let text = substitute(text, '<code class="vim-script">', '<code class="lang-vim">', 'g')
  let text = substitute(text, '\Vもう少し:Captureについて (unite.vim)', 'unite.vimで:Capture', 'g')
  let text = substitute(text, '<pre>\s*<code[^>]*>\(.\{-}\)</code>\s*</pre>', '\=s:pre(submatch(1))', 'g')
  let text = substitute(text, '<pre>\s*\([^<].\{-}\)</pre>', '\=s:pre(submatch(1))', 'g')
  let text = substitute(text, '<code>\(.\{-}\)</code>', '\=s:code(submatch(1))', 'g')
  let text = substitute(text, '\(<code[^>]*>\)\n', '\1', 'g')
  let text = substitute(text, '/web/[0-9]\+/', '', 'g')
  let text = substitute(text, 'http://farm[0-9]\.static\.flickr\.com/[^"]\+/\([^/]\+\)\.jpg', '/vim-users-jp/assets/images/\1.jpg', 'g')
  let text = substitute(text, 'http://farm[0-9]\.staticflickr\.com/[^"]\+/\([^/]\+\)\.jpg', '/vim-users-jp/assets/images/\1.jpg', 'g')
  let text = substitute(text, 'http://gyazo\.com/\([^/]\+\)\.png', '/vim-users-jp/assets/images/\1.png', 'g')
  let text = substitute(text, 'http://cache\.gyazo\.com/\([^/]\+\)\.png', '/vim-users-jp/assets/images/\1.png', 'g')
  let text = substitute(text, 'http://img\.skitch\.com/\([^/]\+\)\.jpg', '/vim-users-jp/assets/images/\1.jpg', 'g')
  let text = substitute(text, 'http://www\.cse\.iitm\.ac\.in/\~osslab/joomla/images/stories/vim-editor_logo\.png', '/vim-users-jp/assets/images/Vim-editor_logo.png', 'g')
  let text = substitute(text, 'http://www\.wayfaring\.info/wp-content/uploads/2007/03/miami-winter-music-conference.jpg', '/vim-users-jp/assets/images/miami-winter-music-conference.jpg', 'g')

  let text = substitute(text, 'http://www\.jmorganmarketing\.com/wp-content/uploads/2008/06/\(long-line\.jpg\)', '/vim-users-jp/assets/images/\1', 'g')
  let text = substitute(text, 'http://www\.yougottabehere\.com/media/resampled/articleElement/1026/\(resampled_Jan_11_2010_amtrak_cascades_train_600\.jpg\)', '/vim-users-jp/assets/images/\1', 'g')
  let text = substitute(text, 'http://vaidehiparikh\.files\.wordpress\.com/2012/08/\(full-20earth2\.jpg\)', '/vim-users-jp/assets/images/\1', 'g')
  let text = substitute(text, 'http://images\.paraorkut\.com/img/pics/images/a/\(airplane-13372\.jpg\)', '/vim-users-jp/assets/images/\1', 'g')
  let text = substitute(text, 'http://bbs50\.meiwasuisan\.com/bbs/kaiki/img/\(13265275940001\.jpg\)', '/vim-users-jp/assets/images/\1', 'g')
  let text = substitute(text, 'http://www\.gentoo\.org/images/\(glogo-small\.png\)', '/vim-users-jp/assets/images/\1', 'g')

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
      if v:exception =~ '^Vim:Interrupt'
        return
      endif
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
