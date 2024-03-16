@echo off
:: ... (rest of the code)

:: Get the script's directory
FOR %%f IN ("%~dp0") DO SET script_dir=%%~ff

:: Change the directory and execute git commands
cd %script_dir%
if not exist stable-cascade-one-click-installer (
    echo "Project not found. Initializing download..."
    git clone https://github.com/EtienneDosSantos/stable-cascade-one-click-installer
) else (
    echo "Updating project..."
    git pull 
)

echo "Done!" 
