#!/bin/bash

pdflatex $1
xdg-open ${1%.tex}.pdf

rm ${1%.tex}.log
rm *.aux
