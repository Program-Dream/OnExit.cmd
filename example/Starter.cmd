:: Go to parent directory. Typically the folder structure would be the other way around,
:: since OnExit.cmd will be located in the main application folder or a subfolder. This isn't
:: done here, because that would require to duplicate the code and all changes made to it.
@cd ..

:: Start the application using the batchProcessManager.
@"batchProcessManager.cmd" "%~dp0Application.cmd" "%~dp0OnExitAction.cmd"