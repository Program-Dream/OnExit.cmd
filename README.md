# OnExit.cmd
This batch tool runs in the background and listens for your batch program to close, so you can do cleanups and more after your batch process was terminated.

## How to use
You can find an executable example here: [OnExit.cmd/example](example).  

Generally what you need to do is starting the [batchProcessManager](batchProcessManager.cmd), which will:
  - Start your application.
  - Listen whether your application is still running or has been closed.
  - Execute the action that should happen after the application terminatd.  

The basic syntax is: 
```cmd
batchProcessManager <your-application> <on-exit-action>
```
  - `<your-application>` is the file containing your main application, which will be visible to the user.
  - `<on-exit-action>` is the file that should be executed after the main application was closed. It will be executed hidden and should terminate on its own. If necessary though, it can spawn a new process that is visible to the user.
  
## How it works
The [batchProcessManager](batchProcessManager.cmd) first finds out his own process identifier (PID) via taklist. Then it starts the [OnExitListener](OnExitListener.cmd) as a new background process using wscripts run command. It will check constantly if the main process, in which the given application will be executed, is still running. If not, the on-exit-action will be executed in the same process as the OnExitListener. As soon as your custom on-exit-action script has terminated, all used processes are closed.
