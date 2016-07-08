mingw-get install win_flex win-bison
#msys-flex msys-bison

scons llvm=yes build=release openmp=true osmesa

# move the driver
move "%PREFIX%\lib\python\libOSMesa.dll" "%PREFIX%\lib\"

# move the include files
move "%PREFIX%\lib\python\libosmesa.dll" "%PREFIX%\include\GL\"
