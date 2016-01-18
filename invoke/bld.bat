"%PYTHON%" setup.py install
if errorlevel 1 exit 1

IF %PY3K% EQ 0 (
    @RD /S /Q "C:\Users\Korijn\Miniconda\envs\_build\Lib\site-packages\invoke-0.11.1-py2.7.egg\invoke\vendor\yaml3"
)
IF %PY3K% EQ 1 (
    @RD /S /Q "C:\Users\Korijn\Miniconda\envs\_build\Lib\site-packages\invoke-0.11.1-py2.7.egg\invoke\vendor\yaml2"
)

:: Add more build steps here, if they are necessary.

:: See
:: http://docs.continuum.io/conda/build.html
:: for a list of environment variables that are set during the build process.
