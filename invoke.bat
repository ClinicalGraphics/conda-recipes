REM configure according to your preferences
set TARGET=clinicalgraphics
set PKG=invoke
set VER=0.11.1
set CONDA_BLD_DIR=%userprofile%\Miniconda3\conda-bld
set BUILD_PLATFORM=linux-64
set BUILD_NR=0
REM configure these lists for the pythons and platforms you want to support
set pythons=26 27 33 34 35
set platforms=win-32 win-64 linux-32 linux-64 osx-64

REM try not to touch the rest of the code
for %%p in (%pythons%) do (
    conda build .\%PKG% --python %%p --no-anaconda-upload
)

for %%p in (%pythons%) do (
    conda convert -o "%CONDA_BLD_DIR%" -p all "%CONDA_BLD_DIR%\%BUILD_PLATFORM%\%PKG%-%VER%-py%%p_%BUILD_NR%.tar.bz2"
)

for %%p in (%pythons%) do (
  for %%o in (%platforms%) do (
    anaconda upload "%CONDA_BLD_DIR%\%%o\%PKG%-%VER%-py%%p_%BUILD_NR%.tar.bz2" -u %TARGET%
  )
)
