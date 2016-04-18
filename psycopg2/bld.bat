set VERSION_NAME=py%PY_VER%-pg9.4.4-release
if %PY_VER%==3.5 (
    set VERSION_NAME=py3.5
)

if %ARCH%==32 (
    set ARCH_NAME=win32
)
if %ARCH%==64 (
    set ARCH_NAME=win-amd64
)

powershell -Command "$progressPreference = 'silentlyContinue'; Invoke-WebRequest http://www.stickpeople.com/projects/python/win-psycopg/2.6.1/psycopg2-2.6.1.%ARCH_NAME%-%VERSION_NAME%.exe -OutFile installer.exe"

easy_install installer.exe

if errorlevel 1 exit 1
