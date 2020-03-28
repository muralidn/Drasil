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

build: Projectile$(TARGET_EXTENSION)

Projectile$(TARGET_EXTENSION): InputParameters.hpp OutputFormat.hpp Calculations.hpp Control.cpp InputParameters.cpp OutputFormat.cpp Calculations.cpp
	"$(CXX)" Control.cpp InputParameters.cpp OutputFormat.cpp Calculations.cpp --std=c++11 -o Projectile$(TARGET_EXTENSION)

run: build
	./Projectile$(TARGET_EXTENSION) $(RUNARGS)

doc: doxConfig InputParameters.hpp OutputFormat.hpp Calculations.hpp Control.cpp
	doxygen doxConfig

.PHONY: build run doc