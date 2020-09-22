#!/bin/bash

# Convert ZX diagrams created with tikzit to SVG files

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]
then
  echo "Usage: $0 tikzit-file.tikz [output.svg]" >&2
  exit 1
fi

INPUT=$(readlink -f $1)
OUTPUT="$INPUT.svg"
if [ "$#" -eq 2 ]
then
  OUTPUT=$(readlink -f $2)
fi

if [ ! -x $(command -v pdf2svg) ] ; then
    echo "pdf2svg is required."
    exit 2
fi

WORKING_DIR="$DIR/fromTikz"
cd $WORKING_DIR

FROM_TIKZ="fromTikz"
TMP="$FROM_TIKZ.tmp"

echo "\\documentclass[crop,tikz,convert={outfile=$OUTPUT,command=\\unexpanded{
pdf2svg \\infile\\space\\outfile}
},multi=false]{standalone}

\\def\\tikzFileInput{$INPUT}
\\input{$FROM_TIKZ.tex}
" > $TMP.tex

pdflatex -shell-escape $TMP.tex

rm -f $TMP.aux $TMP.log $TMP.pdf $TMP.tex
