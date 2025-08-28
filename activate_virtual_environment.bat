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
SETLOCAL
SET "CURRENT_DIRECTORY=%~dp0"
CALL "%CURRENT_DIRECTORY%ansi.bat" --q || EXIT /B 1
CALL "%CURRENT_DIRECTORY%run_in_python_package_root.bat" || EXIT /B 1
ENDLOCAL

SET VIRTUAL_ENV_NAME="venv"

IF NOT EXIST %VIRTUAL_ENV_NAME% (
    ECHO %ERROR_COLOUR%Virtual environment '%VIRTUAL_ENV_NAME%' does not exist. Please create it first.%ANSI_RESET%
    EXIT /B 1
)

REM Activate the virtual environment
CALL %VIRTUAL_ENV_NAME%\Scripts\activate