srs: PIDController_SRS.pdf

PIDController_SRS.pdf: PIDController_SRS.tex
	lualatex $(TEXFLAGS) PIDController_SRS
	-bibtex $(BIBTEXFLAGS) PIDController_SRS
	lualatex $(TEXFLAGS) PIDController_SRS
	lualatex $(TEXFLAGS) PIDController_SRS

.PHONY: srs
