@ECHO OFF

REM TO CALL:
REM CALL "utils\run_in_package_root.bat"

REM Requirements:
REM ansi.bat

REM -----
REM ENSURE WE ARE RUNNING IN THE PACKAGE ROOT (v2)
REM -----

REM ----- Invoke Our Utility Scripts -----
CALL "ansi.bat"

REM Set the name of the scripts dir.
set SCRIPTS_DIRECTORY_NAME=scripts

REM Get the directory where the batch file is located
SET "SCRIPT_DIR=%~dp0"

REM Normalize SCRIPT_DIR to remove trailing slash if present
IF "%SCRIPT_DIR:~-1%"=="\" SET "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM Get the current working directory
SET "CURRENT_DIR=%CD%"

REM Determine if we are in the scripts directory or the parent directory
IF /I "%CURRENT_DIR%"=="%SCRIPT_DIR%" (
    ECHO %INFO_COLOUR%Running from the "scripts" directory.%ANSI_RESET%
    ECHO %PENDING_COLOUR%Moving up one level...%ANSI_RESET%
    CD ..
    ECHO %SUCCESS_COLOUR%Changed directory to the package root!%ANSI_RESET%
) ELSE IF /I "%CURRENT_DIR%\%SCRIPTS_DIRECTORY_NAME%"=="%SCRIPT_DIR%" (
    ECHO %INFO_COLOUR%Running from the parent directory.%ANSI_RESET%
) ELSE (
    ECHO %ERROR_COLOUR%Running from an unexpected directory. Please run from the package root or the "scripts" directory.%ANSI_RESET%
    ECHO %INFO_COLOUR%Current directory: %CURRENT_DIR%%ANSI_RESET%
    ECHO %INFO_COLOUR%Script directory: %SCRIPT_DIR%%ANSI_RESET%
    ECHO %INFO_COLOUR%Checked if the following are equal:%ANSI_RESET%
    ECHO %INFO_COLOUR%A: "%CURRENT_DIR%\%SCRIPTS_DIRECTORY_NAME%"%ANSI_RESET%
    ECHO %INFO_COLOUR%B: "%SCRIPT_DIR%"%ANSI_RESET%
    GOTO :ENDOFSCRIPT
)