@echo off
REM  Turn echoing off and don't show echo off command
REM
cls
echo.
echo.
echo *******************************************
echo *        CearCase ATCSim Kaufbeuren       *
echo *           Transfer Mastership           *
echo *******************************************
echo.
echo.

REM See if this script was run from GUI or command line.
REM cmdcmdline will contain the script name if called from
REM gui. If from gui, go to GUI, otherwise, go to cmd_line
REM
set interactive=1
echo %cmdcmdline% | find /i "%~0" >nul
if not errorlevel 1 set interactive=0
if %interactive%==0 (goto gui) else (goto cmd_line)

REM ################ Called from Command Line #############################

:cmd_line

set _exitStatus=0
set _argcActual=0
set _argcExpected=3

REM #   See if there are 3 arguments as expected; If not, call ShowUsage
REM #   and exit script, otherwise, rsh to CC server and execute transfer script
REM #
for %%i in (%*) do set /A _argcActual+=1

if %_argcActual% NEQ %_argcExpected% (

  call :_ShowUsage %0%

  set _exitStatus=1

  goto:_EOF
)

rsh 192.168.100.12 -l root /usr/bin/transfer_mastership.sh %1 %2 %3
goto:_EOF

REM ################ Called from GUI #############################

:gui
echo.
echo.
echo *******************************************
echo *           Transfer Mastership           *
echo *******************************************
echo * Destination = ufa | atcsim | kb | scott *
echo *******************************************
echo.
echo.
pause
REM #
REM #   THis script executed via GUI, prompt for the arguments
REM #   and rsh to beluga and execute transfer script
REM #   Make user hit "return" when script finishes so he
REM #   can see results of transfer mastership script.
REM #
 set /p branch="Enter Branch      --> "
 set /p vob="Enter Vob         --> "
 set /p destination="Enter Destination --> "
 rsh 192.168.100.12 -l root /usr/bin/transfer_mastership.sh %branch% %vob% %destination%
 echo.
 set /p the_end="Hit enter to exit "
 goto:_EOF

REM ##############################################################




:_ShowUsage

  echo.
  echo [USAGE]: %~1 BRANCH VOB DESTINATION
  echo.
  echo [USAGE]: VOB = attower, ateditor, ...
  echo [USAGE]: DESTINATION = kb, atcsim, ufa
  echo.

  if NOT "%~2" == "" (

    echo %~2

    echo.
  )

  goto:eof

:_EOF


echo.

cmd /c exit %_exitStatus%

