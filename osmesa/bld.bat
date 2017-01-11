:: LLVM linking without quotes - breaks llvm.py folder check
SET LLVM=%LIBRARY_PREFIX%

:: Have to use CALL to prevent the script from exiting after calling SCons
CALL scons llvm=yes texture_float=yes shared-glapi=yes static=yes machine=x86_64 MSVC_VERSION=14.0 platform=windows build=release openmp=true osmesa libgl-gdi

:: move the osmesa.dll and other files generated to LIBRARY_BIN
xcopy "build\windows-x86_64\gallium\targets\osmesa" "%LIBRARY_BIN%\" /O /X /E /H /K

:: move the opengl32.dll and other files generated to LIBRARY_BIN
xcopy "build\windows-x86_64\gallium\targets\libgl-gdi" "%LIBRARY_BIN%\" /O /X /E /H /K

:: move the header files for mesa to LIBRARY_INC\GL
xcopy include\GL "%LIBRARY_INC%\GL\" /O /X /E /H /K
