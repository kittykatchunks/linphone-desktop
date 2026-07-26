# Linphone Desktop — MarandarTech Fork

Fork of [BelledonneCommunications/linphone-desktop](https://github.com/BelledonneCommunications/linphone-desktop) for white-label branding.

## Status

| Item | Status |
|------|--------|
| Fork | Done (`kittykatchunks/linphone-desktop`) |
| Submodule remap | Top-level done (GitHub/Google mirrors) |
| Build tools | Installed (VS 2022, CMake 4.4, Qt 6.10.0, Python 3.12, NASM) |
| SDK submodules | **BLOCKED** — 27 deps on `gitlab.linphone.org` (offline) |
| Build from source | Blocked until GitLab returns |
| Stock installer | Downloaded: Linphone 6.2.0 (2026-07-16) |

## Build Prerequisites (Windows)

- Visual Studio 2022 Build Tools (C++ workload)
- CMake 4.4+ (`winget install Kitware.CMake`)
- Python 3.12+ (`winget install Python.Python.3.12`)
- NASM 3+ (`winget install NASM.NASM`)
- Qt 6.10.0 at `C:\Qt\6.10.0\msvc2022_64` (installed via `aqtinstall`)

## Build (once GitLab is back)

```batch
git submodule update --init --recursive
build.bat RelWithDebInfo
```

Or manually:
```powershell
$env:Qt6_DIR = "C:\Qt\6.10.0\msvc2022_64\lib\cmake\Qt6"
$env:PATH = "C:\Qt\6.10.0\msvc2022_64\bin;$env:PATH"
mkdir build; cd build
cmake .. -DCMAKE_BUILD_PARALLEL_LEVEL=10 -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build . --parallel 10 --config RelWithDebInfo
cmake --install .
# Run: .\OUTPUT\bin\linphone.exe
```

## Branding (Future)

CMake variables for white-labeling:
```cmake
-DLINPHONEAPP_APPLICATION_NAME="MarandarPhone"
-DLINPHONEAPP_EXECUTABLE_NAME="marandarphone"
```

Branding files to customize:
- `Linphone/application_info.cmake` — app name, version, bundle ID
- `Linphone/resources/` — icons, splash, images
- `Linphone/ui/` — QML UI colors/theme

## Testing with Stock App

Install `Linphone-6.2.0-win64.exe` from Downloads and configure:
- SIP domain: `sip.marandartech.com`
- Transport: UDP
- Username/password from Flexisip `users.db`
