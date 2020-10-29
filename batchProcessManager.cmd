@echo off
setlocal enableDelayedExpansion

  :: Checking if 2 parameters were given.
  if "%~2"=="" echo:Not enough parameters given. (2 required) & pause & exit

  :: Recieving the PID of the batchProcessManager instance itself.
  set "title=bpm[%~n1_%date%_%time%_%random%]"
  title %title%
  for /F "tokens=2 usebackq" %%P IN (`tasklist /NH /FI "WINDOWTITLE eq %title%*"`) do set "PID=%%P"

  :: Activating the listener process.
  wscript runInBackground.vbs "OnExitListener.cmd %PID% ^"%~2^"" //nologo

endlocal

:: Execute main program now.
if exist "%~dp1" cd /d "%~dp1"
%1