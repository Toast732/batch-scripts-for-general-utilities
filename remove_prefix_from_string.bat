@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM Description:
REM This script removes a given prefix from a given string.

REM TO CALL:
REM CALL "remove_prefix_from_string.bat" <%input_string%> <%prefix%> <output_string>

REM Requirements:
REM does_string_start_with.bat
REM booleans.bat
REM string_length.bat

REM -----
REM REMOVE PREFIX FROM STRING (v1)
REM -----

REM ----- Invoke Our Utility Scripts -----
SET "CURRENT_DIRECTORY=%~dp0"
CALL "%CURRENT_DIRECTORY%booleans.bat" || EXIT /B 1

REM Store our input string.
SET "INPUT_STRING=%1"

REM Store our prefix.
SET "PREFIX=%2"

REM Check if the input string starts with the given prefix.
CALL "%~dp0does_string_start_with.bat" %INPUT_STRING% %PREFIX% DOES_START_WITH || EXIT /B 1

REM If the input string does not start with the prefix, then just return the input string as-is.
IF "%DOES_START_WITH%"=="%FALSE%" (
    ENDLOCAL & SET "%3=%INPUT_STRING%" & EXIT /B 0
)

REM Get the length of the prefix string, so we know how much to cut off.
CALL "%~dp0string_length.bat" "%PREFIX%" STRING_LENGTH

REM Remove the prefix from the input string, and return that as the output string.
SET "RESULT=!INPUT_STRING:~%STRING_LENGTH%!"

ENDLOCAL & SET "%3=%RESULT%"