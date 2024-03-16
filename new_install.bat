@echo off
REM Get the script's directory
set "script_dir=%~dp0"

REM Change the directory and execute git commands
cd /d "%script_dir%"
if not exist "stable-cascade-one-click-installer" (
    echo Project not found. Initializing download...
    git clone https://github.com/EtienneDosSantos/stable-cascade-one-click-installer
) else (
    echo Updating project...
    cd stable-cascade-one-click-installer && git pull
)

REM Ensure we are in the stable-cascade-one-click-installer directory for Python environment setup
cd /d "%script_dir%stable-cascade-one-click-installer"

REM Set error flag
setlocal EnableDelayedExpansion
set "errorflag=0"

REM Check for Python and exit if not found
where python >nul 2>&1
if %errorlevel% neq 0 (
  echo Error: python is not installed.
  exit /b 1
)

REM Create a virtual environment
if not exist "venv" (
  python -m venv venv
)

REM Upgrade pip before `pip install`
call .\venv\Scripts\python -m pip install --upgrade pip

REM Install other requirements
call .\venv\Scripts\pip install -r requirements.txt

REM Move new_install.bat into the root of stable-cascade-one-click-installer directory
move "%script_dir%new_install.bat" "%script_dir%stable-cascade-one-click-installer\"

echo Installation completed. Execute 'run.bat' script to start generating!

pause
