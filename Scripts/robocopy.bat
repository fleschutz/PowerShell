@echo off

set SOURCE=D:
set DESTINATION=Z:
set OPTIONS=/MIR /FFT /MT

title ROBOCOPY
echo ROBOCOPY
echo ========
echo.
echo From:    %SOURCE%
echo.
echo To:      %DESTINATION%
echo.
echo Options: %OPTIONS%
echo.
echo.
echo.
echo.
echo NOTE: Data at destination will be overwritten! Are you sure?
echo.
pause

robocopy %SOURCE%  %DESTINATION%  %OPTIONS%

echo DONE.
echo.
pause
exit 0
