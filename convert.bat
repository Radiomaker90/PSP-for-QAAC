
@echo off
chcp 65001 >nul
setlocal

title PSP for QAAC - Audio Converter

REM 基準フォルダー（BATファイルの場所）
set "BASE=%~dp0"

REM QAACの場所
set "QAAC=%BASE%qaac64.exe"

REM 入力・出力フォルダー
set "INPUT=%BASE%input"
set "OUTPUT=%BASE%output"

REM QAACの存在確認
if not exist "%QAAC%" (
    echo [ERROR] qaac64.exe が見つかりません。
    pause
    exit /b 1
)

REM 必要なフォルダーを作成
if not exist "%INPUT%" mkdir "%INPUT%"
if not exist "%OUTPUT%" mkdir "%OUTPUT%"

echo.
echo ==================================
echo       PSP for QAAC
echo ==================================
echo.

REM MP3・FLAC変換
for %%F in ("%INPUT%\*.mp3" "%INPUT%\*.flac") do (
    if exist "%%~fF" (
        echo 変換中: %%~nxF

        if exist "%OUTPUT%\%%~nF.m4a" (
            echo [SKIP] 出力ファイルが既に存在します。
        ) else (
            "%QAAC%" --abr 256 --rate 44100 "%%~fF" -o "%OUTPUT%\%%~nF.m4a"

            if errorlevel 1 (
                echo [ERROR] %%~nxF
            ) else (
                echo [OK] %%~nxF
            )
        )
        echo.
    )
)

echo ==================================
echo 変換処理が完了しました。
echo ==================================

pause
