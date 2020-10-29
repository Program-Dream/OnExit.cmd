if "%~1"=="" echo:No Parameter given. & pause & exit
::if not exists "%~f1" echo:The parameter is not valid file path. & pause & exit

set "title=bpm[%~n1_%date%_%time%_%random%]"
title %title%
for /F "tokens=2 usebackq" %%P IN (`tasklist /NH /FI "WINDOWTITLE eq %title%*"`) do set "PID=%%P"

wscript runInBackground.vbs "OnExitListener.cmd %PID%" //nologo
pause