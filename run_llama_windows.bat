@echo off
REM LLM launcher for llama.cpp models on Windows (PowerShell required)

SET "MODEL_DIR=%USERPROFILE%\code\ai-llmacpp\models\"
SET "LLAMA_BIN=%USERPROFILE%\code\llama.cpp\build\bin\Release\main.exe"
SET "CTX=4096"

REM Prompt for model key and optional prompt
IF "%~1"=="" (
    ECHO Usage: run-llama-windows.bat model-name-or-prefix [prompt]
    ECHO.
    ECHO Example:
    ECHO   run-llama-windows.bat mistral "List 5 Windows tips"
    ECHO.
    ECHO Available models:
    powershell -Command "Get-ChildItem '%MODEL_DIR%' -Recurse -Filter *.gguf | ForEach-Object { '  ' + $_.Name }"
    EXIT /B 1
)

SET "MODEL_KEY=%~1"
SHIFT
SET "PROMPT=%*"
IF "%PROMPT%"=="" SET "PROMPT=You are a helpful assistant. Say hello."

REM Use PowerShell to find matching models
FOR /F "usebackq delims=" %%F IN (`powershell -Command "Get-ChildItem '%MODEL_DIR%' -Recurse -Filter '%MODEL_KEY%*.gguf' | Sort-Object FullName | ForEach-Object { $_.FullName }"`) DO (
    SET "MATCHED=%%F"
    GOTO :found_model
)

ECHO No models found matching "%MODEL_KEY%"
EXIT /B 1

:found_model
ECHO → Using model: %MATCHED%
ECHO → Prompt: %PROMPT%
"%LLAMA_BIN%" ^
  -m "%MATCHED%" ^
  --ctx-size %CTX% ^
  -i ^
  -p "%PROMPT%"
