#!/bin/bash

ls _posts/*.html |\
while read line; do
  git rm --cache $line 2> /dev/null
done

git add _posts/2009-07-24-Online-sg-5-Vim-LT-rtf.html
git add _posts/2009-12-22-USSR-1-neocomplcache.html
git add _posts/2011-05-20-newremoteprotocol.html
git add _posts/2012-02-05-english.html

while read line; do
  grep -il "^author: $line" _posts/*.html |\
  while read file; do
    [ "x$file" != "x" ] && git add $file
  done
done <<@EOF
-from_kyushu
kana
mattn
Sixeight
Shougo
Sora Harakami
t9md
thinca
-tsukkee
tyru
ujihisa
-ukstudio
@EOF
