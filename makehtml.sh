#!/bin/bash
pandoc --biblio src/main.bib --csl src/ieee.csl --mathjax -s --template src/template.html --css css/markdown7.css -H src/header.html cvxguide.md -o cvxguide.html