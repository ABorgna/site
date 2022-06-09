.DEFAULT_GOAL := all

# tool macros
TIKZ_TO_SVG := ./util/fromTikz.sh

# path macros
FIGURES_PATH := img/tikz

# target macros
FIGURES_TIKS := $(wildcard $(FIGURES_PATH)/*.tikz)
FIGURES_SVGS := $(FIGURES_TIKS:.tikz=.svg)

$(FIGURES_SVGS): %.svg : %.tikz
	$(TIKZ_TO_SVG) $< $@

# clean files list
CLEAN_LIST := $(FIGURES_SVGS)

# phony rules
.PHONY: all
all: figures

.PHONY: figures
figures: $(FIGURES_SVGS)

.PHONY: run
run: figures
	@echo "Open the server address indicated here:"
	@python3 -m http.server

.PHONY: clean
clean:
	@echo CLEAN $(CLEAN_LIST)
	@rm -f $(CLEAN_LIST)
