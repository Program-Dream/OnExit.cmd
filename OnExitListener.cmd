@echo off

:main_loop
  tasklist /NH /FI "PID eq %~1" | findstr "%~1" >nul || goto onExit
goto main_loop

:onExit
  if exist "%~dp2" cd /d "%~dp2"
  %2
exit