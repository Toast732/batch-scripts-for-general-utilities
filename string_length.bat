@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM Description:
REM You can use this script to get the length of a given string.

REM TO CALL:
REM CALL "string_length.bat" <%input_string%> <string_length>

REM Requirements:
REM None!

REM -----
REM GET LENGTH OF STRING (v1)
REM -----

REM Use ENDLOCAL to ensure that this variable get's passed down to the calling script. Default the length to 0, and our string to the given string.
ENDLOCAL & SET "%2=0" & SET "str=%~1"

REM Create our loop, to go through each character.
:STRINGLENGTHLOOP
REM If our string is not defined, then exit.
IF NOT DEFINED str EXIT /B 0
REM Remove 1 character from our string.
SET "str=!str:~1!"
REM Add 1 to our tally.
SET /A "%2+=1"
REM Repeat.
GOTO STRINGLENGTHLOOP