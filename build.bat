@echo off
REM ============================================================================
REM build.bat — Build Linphone Desktop (Windows, MSVC 2022, Qt 6.10.0)
REM
REM Prerequisites:
REM   - Visual Studio 2022 Build Tools (with C++ workload)
REM   - Qt 6.10.0 at C:\Qt\6.10.0\msvc2022_64
REM   - CMake, Python 3, NASM in PATH
REM
REM Usage:
REM   build.bat [RelWithDebInfo|Release|Debug]
REM ============================================================================

set BUILD_TYPE=%1
if "%BUILD_TYPE%"=="" set BUILD_TYPE=RelWithDebInfo

echo [BUILD] Configuration: %BUILD_TYPE%

REM --- Set up Visual Studio environment ---
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64

REM --- Set Qt paths ---
set Qt6_DIR=C:\Qt\6.10.0\msvc2022_64\lib\cmake\Qt6
set PATH=C:\Qt\6.10.0\msvc2022_64\bin;%PATH%

REM --- Create build directory ---
if not exist build mkdir build
cd build

REM --- Configure ---
echo [BUILD] Running CMake configure...
cmake .. -DCMAKE_BUILD_PARALLEL_LEVEL=10 -DCMAKE_BUILD_TYPE=%BUILD_TYPE%
if %ERRORLEVEL% neq 0 (
    echo [BUILD] CMake configure FAILED
    exit /b 1
)

REM --- Build ---
echo [BUILD] Building...
cmake --build . --parallel 10 --config %BUILD_TYPE%
if %ERRORLEVEL% neq 0 (
    echo [BUILD] Build FAILED
    exit /b 1
)

REM --- Install ---
echo [BUILD] Installing to OUTPUT...
cmake --install .

echo [BUILD] Done! Output in build\OUTPUT\bin\
