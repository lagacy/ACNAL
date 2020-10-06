@echo off
echo %~dp0

IF exist doxygen ( echo directory doxygen exist ) ELSE ( echo Cloning doxygen && git clone https://github.com/doxygen/doxygen.git )

cd doxygen

IF exist build ( echo build directory exist) ELSE ( echo Generating build directory && mkdir build && cd build && echo Generation project && cmake .. && echo Start building project && cmake --build . && echo Installing project && cmake --install . )

cmd /k