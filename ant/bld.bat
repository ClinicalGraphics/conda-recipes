:: Setup
set HAMCREST=hamcrest-core-1.3.jar
where java > where-java.txt
set /p JAVA_EXE=<where-java.txt
python -c "from os.path import dirname; print(dirname(dirname(r'%JAVA_EXE%')))" > java-home.txt
set /p JAVA_HOME=<java-home.txt
set BUILD_CACHE=%RECIPE_DIR%\\..\\build\\cache
if not exist %BUILD_CACHE% (
  mkdir %BUILD_CACHE%
)

:: Download
:: Build won't work without this installed. Potentially a bug.
:: see http://archive.linuxfromscratch.org/mail-archives/blfs-book/2014-May/042604.html
if not exist %BUILD_CACHE%\\%HAMCREST% (
  curl -k -o %BUILD_CACHE%\\%HAMCREST% "https://hamcrest.googlecode.com/files/%HAMCREST%"
)
copy %BUILD_CACHE%\\%HAMCREST% lib\\optional\\%HAMCREST%

:: Install
build.bat -Ddist.dir=%LIBRARY_PREFIX% dist
ant -f fetch.xml -Ddest=system