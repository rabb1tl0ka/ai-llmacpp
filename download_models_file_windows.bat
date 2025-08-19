@echo off
setlocal enabledelayedexpansion
echo ≡ Downloading GGUF models...

REM Read each line from model_urls.txt as "path,url"
for /f "usebackq tokens=1,2 delims=," %%a in ("model_urls.txt") do (
  set "MODEL_PATH=%%a"
  set "MODEL_URL=%%b"

  call :trim MODEL_PATH
  call :trim MODEL_URL

  if not exist "!MODEL_PATH!" (
    echo ↓ Downloading !MODEL_PATH!
    powershell -Command "Invoke-WebRequest '!MODEL_URL!' -OutFile '!MODEL_PATH!'"
  ) else (
    echo ✓ Already exists: !MODEL_PATH!
  )
)
goto :eof

REM Trim leading/trailing spaces
:trim
setlocal enabledelayedexpansion
set "str=!%1!"
for /f "tokens=* delims= " %%x in ("!str!") do endlocal & set "%1=%%x"
goto :eof
