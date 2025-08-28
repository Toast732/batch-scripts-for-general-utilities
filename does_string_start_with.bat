@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM Description:
REM This script checks if a given string starts with another given string.

REM TO CALL:
REM CALL "does_string_start_with.bat" <%input_string%> <%prefix%> <does_start_with>

REM Requirements:
REM string_length.bat
REM booleans.bat

REM -----
REM CHECK IF STRING STARTS WITH ANOTHER (v1)
REM -----

REM ----- Invoke Our Utility Scripts -----
SET "CURRENT_DIRECTORY=%~dp0"
CALL "%CURRENT_DIRECTORY%booleans.bat" || EXIT /B 1

REM Store our input string.
SET "INPUT_STRING=%1"

REM Store our prefix.
SET "PREFIX=%2"

REM Get the length of the prefix string, so we know how much to cut off for checking if the strings match.
CALL "%~dp0string_length.bat" %PREFIX% STRING_LENGTH

REM Check if the input string is even long enough to have this prefix.
IF "!INPUT_STRING:~%STRING_LENGTH%!"=="" (
    REM ECHO Input string is shorter than prefix, cannot start with it. Input string: %INPUT_STRING%, Prefix: %PREFIX%
    REM If it's not, then just set that we do not start with this.
    ENDLOCAL & SET "%3=%FALSE%" & EXIT /B 0
)

REM Check if the input string matches our prefix.
IF /I "!INPUT_STRING:~0,%STRING_LENGTH%!"=="%PREFIX%" (
    REM ECHO Input string starts with prefix. Input string: %INPUT_STRING%, Prefix: %PREFIX%
    REM If it does, then set that it does start with it.
    ENDLOCAL & SET "%3=%TRUE%"
) ELSE (
    REM ECHO Input string does not start with prefix. Input string: %INPUT_STRING%, Prefix: %PREFIX%
    REM ECHO Checked if:
    REM ECHO A: "!INPUT_STRING:~0,%STRING_LENGTH%!"
    REM ECHO B: "%PREFIX%"
    REM ECHO Are Equal.
    REM Otherwise, set that it does not.
    ENDLOCAL & SET "%3=%FALSE%"
)