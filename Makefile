CONTENT_DIR=content
CODE_DIR=code
FIGURES_DIR=figures
IMAGES_DIR=images
REFERENCES_DIR=references
SETTINGS_DIR=settings
BUILD_DIR=build

CONTENT_FILES=$(wildcard $(CONTENT_DIR)/*.tex)
CODE_FILES=$(wildcard $(CODE_DIR)/*)
FIGURES_FILES=$(wildcard $(FIGURES_DIR)/*)
IMAGES_FILES=$(wildcard $(IMAGES_DIR)/*.tex)
REFERENCES_FILES=$(wildcard $(REFERENCES_DIR)/*.tex)
SETTINGS_FILES=$(wildcard $(SETTINGS_DIR)/*.tex)

MAIN_SRC=thesis.tex
MAIN_PDF=$(BUILD_DIR)/$(basename $(MAIN_SRC)).pdf

$(MAIN_PDF) : $(MAIN_SRC) $(CONTENT_FILES) $(FIGURES_FILES) $(CODE_FILES) $(SETTINGS_FILES)
	latexmk -auxdir=$(BUILD_DIR) -outdir=$(BUILD_DIR) -xelatex -pdfxelatex="xelatex %O --shell-escape %S" -dvi- -ps- $(MAIN_SRC)

clean:
	rm -rf build

.PHONY: clean
