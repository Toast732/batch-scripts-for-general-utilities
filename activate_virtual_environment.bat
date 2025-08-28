@ECHO OFF

REM TO CALL:
REM CALL "utils\activate_virtual_environment.bat"

REM Requirements:
REM ansi.bat
REM run_in_package_root.bat
REM python
REM a virtual environment named "venv" in the current directory

REM -----
REM ACTIVATE THE VIRTUAL ENVIRONMENT (v1)
REM -----

REM ----- Invoke Our Utility Scripts -----
CALL "ansi.bat"
CALL "run_in_package_root.bat"

SET VIRTUAL_ENV_NAME="venv"

IF NOT EXIST %VIRTUAL_ENV_NAME% (
    ECHO %ERROR_COLOUR%Virtual environment '%VIRTUAL_ENV_NAME%' does not exist. Please create it first.%ANSI_RESET%
    GOTO :ENDOFSCRIPT
)

REM Activate the virtual environment
CALL %VIRTUAL_ENV_NAME%\Scripts\activate