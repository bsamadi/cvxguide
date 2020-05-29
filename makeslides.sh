#!/bin/bash
pandoc --biblio src/main.bib --csl src/ieee.csl --include-in-header css/slides.css --mathjax -t revealjs -V theme=white -V revealjs-url=https://revealjs.com -s --slide-level 2 cvxguideslides.md -o cvxguideslides.html
