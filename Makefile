# This makefile should be the go-to makefile for the document writing I will be doing for the Principles of Communication class
# This make file shouls, on top of generic compilation, should generate both a PDF and a docx file
# This makefile is based off the makefiles I use for my other latex documents, which is one I found on github ages ago, and have modified for personal use

LATEX=xelatex
LATEXOPT=--shell-escape
NONSTOP=--interaction=nonstopmode
LATEXMK=latexmk
LATEXMKOPT=-pdf 
CONTINUOUS=-pvc -view=none

MAIN=main
SOURCES=$(MAIN).tex Makefile Sections/*.tex
FIGURES := $(shell find Images/* -type f)

all:   $(MAIN).pdf

.refresh:
	touch .refresh

$(MAIN).pdf: $(MAIN).tex .refresh $(SOURCES) $(FIGURES)
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
		-xelatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(MAIN)

force:
	touch .refresh
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
            -xelatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

clean:
	$(LATEXMK) -C $(MAIN)
	rm -f $(MAIN).pdfsync
	rm -rf *~ *.tmp
	rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk

once:
	$(LATEXMK) $(LATEXMKOPT) -xelatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

debug:
	$(LATEX) $(LATEXOPT) $(MAIN)

.PHONY: clean force once all

