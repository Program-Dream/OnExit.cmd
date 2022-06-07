@echo off
setlocal enableDelayedExpansion

    :: Checking if 2 parameters were given and if the first one is a valid file.
    if "%~2"=="" echo Not enough parameters given. (2 required) & pause & exit /b 1
    if not exist "%~1" echo The given application does not exist. & pause & exit /b 2
    if not exist "%~2" echo The given onExit action script does not exist. & pause & exit /b 3

    :: Recieving the PID of the batchProcessManager instance itself.
    set "bmp_random=%date%_%time%_%random%"
    set "bmp_random_regex=!bmp_random!"
    set "bmp_random_regex=!bmp_random_regex:/=\/!"
    set "bmp_random_regex=!bmp_random_regex::=\:!"
    title bpm[!bmp_random!]
    for %%A in (cmd.exe WindowsTerminal.exe conhost.exe) do (
        for /f "tokens=2delims=," %%B in (
            '2^>nul tasklist /v /nh /fo csv /fi "imagename eq %%A" ^| findstr /rxc:".*,\".*bpm\[!bmp_random_regex!\].*\""'
        ) do (
            set "PID=%%~B"
        )
    )

    :: Changing the title to a less cryptic one, in case the application
    :: decides to use the default title.
    title %~n1 - BatchProcessManager.

    :: Activating the listener process.
    wscript "%~dp0runInBackground.vbs" "%~dp0OnExitListener.cmd" !PID! "%~f2" //nologo

endlocal

:: Execute main program now.
cd /d "%~dp1"
%1