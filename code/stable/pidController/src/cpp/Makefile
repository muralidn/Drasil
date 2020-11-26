ifeq "$(OS)" "Windows_NT"
    TARGET_EXTENSION=.exe
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S), Linux)
        TARGET_EXTENSION=
    endif
    ifeq ($(UNAME_S), Darwin)
        TARGET_EXTENSION=
    endif
endif

build: PD_Controller$(TARGET_EXTENSION)

PD_Controller$(TARGET_EXTENSION): InputParameters.hpp Calculations.hpp OutputFormat.hpp Populate.hpp ODE.hpp Control.cpp InputParameters.cpp Calculations.cpp OutputFormat.cpp Populate.cpp ODE.cpp
	"$(CXX)" Control.cpp InputParameters.cpp Calculations.cpp OutputFormat.cpp Populate.cpp ODE.cpp --std=c++11 -o PD_Controller$(TARGET_EXTENSION) -I .

run: build
	./PD_Controller$(TARGET_EXTENSION) $(RUNARGS)

doc: doxConfig InputParameters.hpp Calculations.hpp OutputFormat.hpp Populate.hpp ODE.hpp Control.cpp
	doxygen doxConfig

.PHONY: build run doc
