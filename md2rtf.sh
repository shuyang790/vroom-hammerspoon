#!/bin/bash
# !/bin/bash
export LC_CTYPE=UTF-8
hex=`pbpaste | /usr/local/bin/pandoc -t html -s --highlight-style pygments -H ~/.hammerspoon/md2rtf_styles.html | hexdump -ve '1/1 "%.2x"'`
osascript -e "set the clipboard to «data HTML${hex}»"

