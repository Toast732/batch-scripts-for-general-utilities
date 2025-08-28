@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM Description:
REM You can use this script to parse flags passed to a batch script.
REM It will return flags based on the given params, for example, --reset would be defined as a variable named FLAG_reset with a value of true.
REM If given a value like --name value, it would be defined as FLAG_name with a value of value.
REM And lastly, if you defined a variable such as FLAG_ALIAS_n = "--name", then --n value would be remapped to FLAG_name.

REM TO CALL:
REM CALL "utils\flag_parser.bat" %*

REM Requirements:
REM booleans.bat
REM does_string_start_with.bat
REM remove_prefix_from_string.bat

REM -----
REM PARSE THE FLAGS (v1)
REM -----

REM The prefix required for something to be acknowledged as a flag.
SET "FLAG_PREFIX=--"

REM The prefix for us returning a flag variable.
SET "FLAG_VARIABLE_PREFIX=FLAG_"

REM The prefix for flag aliases.
SET "FLAG_ALIAS_PREFIX=FLAG_ALIAS_"

REM ----- Invoke Our Utility Scripts -----
SET "CURRENT_DIRECTORY=%~dp0"
CALL "%CURRENT_DIRECTORY%booleans.bat" || EXIT /B 1

REM Create our loop, to iterate through each argument.
:LOOP

REM If we've hit the end of our arguments, exit.
IF "%1"=="" EXIT /B 0

REM Set the flag name.
SET "GIVEN_FLAG_NAME=%1"

REM Check if this argument starts with the flag prefix.
CALL "%CURRENT_DIRECTORY%does_string_start_with.bat" %GIVEN_FLAG_NAME% %FLAG_PREFIX% IS_FLAG_A_FLAG || EXIT /B 1

REM If this is not a flag, then go to the next argument.
IF "%IS_FLAG_A_FLAG%"=="%FALSE%" (
    REM ECHO Skipping non-flag argument "%1"...
    SHIFT
    GOTO LOOP
)

REM Otherwise, remove the flag prefix from the flag name, pass it back to GIVEN_FLAG_NAME.
CALL "%CURRENT_DIRECTORY%remove_prefix_from_string.bat" %GIVEN_FLAG_NAME% %FLAG_PREFIX% GIVEN_FLAG_NAME || EXIT /B 1

REM Next, we want to check if this is an alias for another flag, so, we want to try to see if we can set a variable using the FLAG_ALIAS_ prefix.
SET "RESOLVED_FLAG_NAME=!%FLAG_ALIAS_PREFIX%%GIVEN_FLAG_NAME%!"

REM If the variable is empty, that means there's no alias for it, so we'll just use the given name.
IF "%RESOLVED_FLAG_NAME%"=="" (
    ECHO No alias found for --%GIVEN_FLAG_NAME%, using as-is.
    SET "RESOLVED_FLAG_NAME=%GIVEN_FLAG_NAME%"
)

REM Now, we want to check if the next argument is another flag, or if it's a value for this flag.
SHIFT

REM Check if we've hit the end of our arguments, and if so, then this is a boolean flag, so set it to true.
IF "%1"=="" (
    REM ECHO Found boolean flag --%RESOLVED_FLAG_NAME%...
    REM ECHO Setting %FLAG_VARIABLE_PREFIX%%RESOLVED_FLAG_NAME% to %TRUE%...
    ENDLOCAL & SET "%FLAG_VARIABLE_PREFIX%%RESOLVED_FLAG_NAME%=%TRUE%"
    EXIT /B 0
)

REM So check if the next argument starts with the flag prefix.
CALL "%CURRENT_DIRECTORY%does_string_start_with.bat" %1 %FLAG_PREFIX% IS_NEXT_ARG_A_FLAG || EXIT /B 1

REM If the next argument is a flag, then this is a boolean flag, so set it to true.
IF "%IS_NEXT_ARG_A_FLAG%"=="%TRUE%" (
    REM ECHO Found boolean flag --%RESOLVED_FLAG_NAME%...
    ENDLOCAL & SET "%FLAG_VARIABLE_PREFIX%%RESOLVED_FLAG_NAME%=%TRUE%"
    GOTO LOOP
) ELSE (
    REM ECHO Found flag --%RESOLVED_FLAG_NAME% with value "%1"...
    REM Otherwise, this is a flag with a value, so set it to the next argument.
    ENDLOCAL & SET "%FLAG_VARIABLE_PREFIX%%RESOLVED_FLAG_NAME%=%1%"
    SHIFT
    GOTO LOOP
)