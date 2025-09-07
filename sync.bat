@echo off
setlocal

:: Paths relative to the batch file directory
set SCRIPT_DIR=%~dp0
set PYTHON_EXE=%SCRIPT_DIR%python-3.9\python.exe
@REM set GIT_EXE=%SCRIPT_DIR%\PortableGit\bin\git.exe
set GIT_EXE=%SCRIPT_DIR%PortableGit\bin\git.exe
set PY_SCRIPT=sync.py

:: Retry loop for Python script
:RETRY
echo Running Python script...
"python" "%SCRIPT_DIR%%PY_SCRIPT%"
if %ERRORLEVEL% NEQ 0 (
    echo Python script failed. Retrying in 5 seconds...
    timeout /t 300 >nul
    goto RETRY
)

echo Python script executed successfully.

echo Adding changes...
"%GIT_EXE%" add .

echo Committing changes...
"%GIT_EXE%" commit -m "Auto-commit after successful Python script execution"

echo Pushing to remote...
"%GIT_EXE%" push

echo All done.
endlocal


echo ========================================
echo All done. Press any key to exit...
pause >nul

