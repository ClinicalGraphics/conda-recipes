IF %PY3K% NEQ 1 (
    RD /S /Q .\invoke\vendor\yaml3
)
IF %PY3K% NEQ 0 (
    RD /S /Q .\invoke\vendor\yaml2
)

"%PYTHON%" setup.py install
if errorlevel 1 exit 1
