@echo off
setlocal

:: Prompt user for destination path
set /p DEST="Enter the destination path for ChromeDriver: "

:: Kill any running chromedriver processes
echo Killing any running chromedriver.exe processes...
taskkill /f /im chromedriver.exe >nul 2>&1

:: Create temp folder
set "TMPDIR=%TEMP%\chromedriver_update"
if exist "%TMPDIR%" rd /s /q "%TMPDIR%"
mkdir "%TMPDIR%"
cd /d "%TMPDIR%"

:: Create PowerShell script to get version and URL
echo $json = Invoke-RestMethod 'https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json' > fetch.ps1
echo $version = $json.channels.Stable.version >> fetch.ps1
echo $url = ($json.channels.Stable.downloads.chromedriver ^| Where-Object { $_.platform -eq 'win64' }).url >> fetch.ps1
echo Set-Content -Path version.txt -Value $version >> fetch.ps1
echo Set-Content -Path url.txt -Value $url >> fetch.ps1

:: Run PowerShell script
powershell -ExecutionPolicy Bypass -File fetch.ps1

:: Read version and URL
set /p VERSION=&lt;version.txt
set /p URL=<url.txt
echo Latest version is %VERSION%
echo Downloading from: %URL%

:: Download ChromeDriver zip
curl -L -o chromedriver.zip %URL%

:: Extract and replace
echo Extracting and updating ChromeDriver...
powershell -NoProfile -Command "Expand-Archive -Path 'chromedriver.zip' -DestinationPath '.' -Force"
copy /Y chromedriver-win64\chromedriver.exe "%DEST%" >nul

:: Clean up
cd /d %TEMP%
rd /s /q "%TMPDIR%"

echo ChromeDriver version %VERSION% has been updated in:
echo %DEST%

exit
