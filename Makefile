SHELL=/bin/bash

SRC=$(wildcard *.md)
DOC=$(basename $(SRC))

FORMS=$(wildcard copyright-consent-forms/*/*/.)

.PHONY: all	html clean $(FORMS)

all: html $(FORMS)

html: $(SRC) | build
	for f in $(DOC); do pandoc -t html -s $$f.md | sed 's/\.md/\.html/g' > build/$$f.html; done
	xdg-open build/README.html &

$(FORMS): | build
	$(MAKE) -C $@ && \
		xdg-open $@/*.pdf &

build:
	mkdir -p $@

clean:
	rm -rf build
