all: compile clean

compile:
	@rm -f *.aux *.bbl *.blg *.idx *.ind *.lof *.lot *.out *.toc *.acn *.acr *.alg *.glg *.glo *.gls *.ist *.fls *.log *.fdb_latexmk *.nlo *.ilg *.nls *.nlg *.bcf *.lol *.run.xml *.synctex.gz *.brf
	@echo "compiling document..."
	pdflatex -synctex=1 -interaction=nonstopmode -file-line-error main.tex
	biber $(filename)
	pdflatex -synctex=1 -interaction=nonstopmode -file-line-error main.tex
	pdflatex -synctex=1 -interaction=nonstopmode -file-line-error main.tex
	@echo "document has been successfully generated!"

clean:
	@echo -n "removing auxiliaries files...\n"
	@rm -f *.aux *.bbl *.blg *.idx *.ind *.lof *.lot *.out *.toc *.acn *.acr *.alg *.glg *.glo *.gls *.ist *.fls *.log *.fdb_latexmk *.nlo *.ilg *.nls *.nlg *.bcf *.lol *.run.xml *.synctex.gz *.brf
	@echo "finish!"
