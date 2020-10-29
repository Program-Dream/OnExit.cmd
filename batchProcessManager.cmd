@echo off
setlocal enableDelayedExpansion

  :: Checking if 2 parameters were given and if the first one is a valid file.
  if "%~2"=="" echo:Not enough parameters given. (2 required) & pause & exit /b 1
  if not exist "%~1" echo:The given application does not exist. & pause & exit /b 2
  if not exist "%~2" echo:The given onExit action script does not exist. & pause & exit /b 3

  :: Recieving the PID of the batchProcessManager instance itself.
  set "title=bpm[%~n1_%date%_%time%_%random%]"
  title %title%
  for /F "tokens=2 usebackq" %%P IN (`tasklist /NH /FI "WINDOWTITLE eq %title%*"`) do set "PID=%%P"

  :: Changing the title to a less cryptic one, in case the application 
  :: decides to use the default title.
  title %~n1 - BatchProcessManager.

  :: Activating the listener process.
  wscript runInBackground.vbs "OnExitListener.cmd %PID% ^"%~2^"" //nologo

endlocal
pause

:: Execute main program now.
cd /d "%~dp1"
%1