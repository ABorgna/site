.DEFAULT_GOAL := all

# tool macros
TIKZ_TO_SVG := ./util/fromTikz.sh
DPQ_BIN := dpq
PDF_TO_SVG := pdf2svg

# path macros
FIGURES_PATH := img/tikz

DPQ_CODE_PATH := examples

# target macros
FIGURES_TIKS := $(wildcard $(FIGURES_PATH)/*.tikz)
FIGURES_SVGS := $(FIGURES_TIKS:.tikz=.svg)

DPQ_SOURCES := $(wildcard $(DPQ_CODE_PATH)/*.dpq)
DPQ_PDFS := $(DPQ_SOURCES:.dpq=.pdf)
DPQ_SVGS := $(DPQ_PDFS:.pdf=.svg)

$(FIGURES_SVGS): %.svg : %.tikz
	$(TIKZ_TO_SVG) $< $@

$(DPQ_PDFS): %.pdf : %.dpq
	$(DPQ_BIN) $< -p $@

$(DPQ_SVGS): %.svg : %.pdf
	$(PDF_TO_SVG) $< $@

# clean files list
CLEAN_LIST := $(FIGURES_SVGS) $(DPQ_SVGS) $(DPQ_PDFS)

# phony rules
.PHONY: all
all: figures

.PHONY: figures
figures: $(FIGURES_SVGS) $(DPQ_SVGS)

.PHONY: run
run: figures
	@echo "Open the server address indicated here:"
	@python3 -m http.server

.PHONY: clean
clean:
	@echo CLEAN $(CLEAN_LIST)
	@rm -f $(CLEAN_LIST)
