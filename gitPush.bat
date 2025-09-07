@echo off
setlocal enabledelayedexpansion

:: Get the directory of the current script
set SCRIPT_DIR=%~dp0
set GIT_EXE=%SCRIPT_DIR%PortableGit\bin\git.exe

:: Check if git.exe exists
if not exist "%GIT_EXE%" (
    echo [ERROR] git.exe not found in the script directory: %SCRIPT_DIR%
    goto end
)

:: Step 1: Add all changes
echo ========================================
echo Step 1: Adding all changes...
"%GIT_EXE%" add .
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to add changes.
    goto end
)
echo [OK] All changes added.
echo ========================================

:: Step 2: Get commit message
set /p commit_msg="Step 2: Enter your commit message: "

:: Step 3: Commit changes
echo.
echo ========================================
echo Step 3: Committing with message "!commit_msg!"...
"%GIT_EXE%" commit -m "!commit_msg!"
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Commit failed.
    goto end
)
echo [OK] Commit successful.
echo ========================================

:: Step 4: Push changes
echo.
echo ========================================
echo Step 4: Pushing to remote...
"%GIT_EXE%" push
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Push failed.
    goto end
)
echo [OK] Push successful.
echo ========================================

:end
echo.
echo ========================================
echo All done. Press any key to exit...
pause >nul
