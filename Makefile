.PHONY: all pdf html

SRCDIR := src
OUTDIR := out
SRCS := $(shell find src -name '*.adoc' -type f -print)

all: html pdf

html: $(patsubst %.adoc, %.html, $(SRCS))

pdf: $(patsubst %.adoc, %.pdf, $(SRCS))

%.pdf: %.adoc
	mkdir -p $(OUTDIR)/pdf
	cp -r "$(shell dirname $<)/images" $(OUTDIR)/pdf 2>/dev/null || true
	asciidoctor-pdf -r asciidoctor-mathematical -a mathematical-format=svg $< -B $(OUTDIR)/pdf -D ../pdf


%.html: %.adoc
	mkdir -p $(OUTDIR)/html
	asciidoctor -B $(OUTDIR) -D html $<
	cp -r "$(shell dirname $<)/images" $(OUTDIR)/html 2>/dev/null || true

clean:
	rm -rf $(OUTDIR)