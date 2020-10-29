@echo off

:main_loop
  tasklist /NH /FI "PID eq %~1" | findstr "%~1" >nul || goto onExit
goto main_loop

:onExit
  %2
exit