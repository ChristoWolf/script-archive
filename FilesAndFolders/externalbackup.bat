@ECHO off
echo Starting copy of data dir: "%~1"
IF [%1] == [] (
    echo ERROR: NO DATADIR SET
    EXIT 1
)
robocopy "%~1." "C:\COPY" /MIR /COPY:DAT /DCOPY:T
echo "robocopy exit code: %ERRORLEVEL%"
IF %ERRORLEVEL% LEQ 7 (
    echo FINISHED SUCCESSFUL
    EXIT 0
) else (
    echo ERROR DETECTED
    EXIT 1
)