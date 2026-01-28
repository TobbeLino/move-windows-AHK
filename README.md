# move-windows-AHK

AutoHotKey script to move windows between monitors with keyboard shortcuts on Windows.

## Features

- Move all windows to the primary monitor with `Ctrl+Alt+F`
- Move all windows to the next monitor (right) with  `Ctrl+Alt+S`
- Automatically wraps around when reaching the last/first monitor
- Maintains relative window position when moving between monitors
- Works with any number of monitors
- Does not move fullscreen windows or minimized windows

## Requirements

- Windows operating system
- [AutoHotKey v2](https://www.autohotkey.com/) installed

## Installation

1. Download and install AutoHotKey from [https://www.autohotkey.com/](https://www.autohotkey.com/)
2. Download or clone this repository
3. Run the script:
   - Run from source: double-click `src/move-windows.ahk`
   - Or compile to an `.exe` (see below)

## Usage

Once the script is running (you'll see an AutoHotKey icon in your system tray):

### Keyboard Shortcuts

- **Ctrl+Alt+F**: Move **all windows** to the **primary** monitor
- **Ctrl+Alt+S**: Move **all windows** to the **next** monitor (cycles through monitors)

The script will:
- Move normal top-level windows while trying to keep their relative position on the target monitor
- Skip windows that shouldn't be moved (for example: fullscreen windows; some special/system windows)
- Handle any number of monitors and wrap around when cycling

### Tray menu

The tray icon menu is intentionally minimal:

- Shows the current version (disabled item)
- Has an **Exit** item

## Running at startup

To have the script run automatically when Windows starts:

1. Press `Win+R` to open the Run dialog
2. Type `shell:startup` and press Enter
3. Create a shortcut to `src/move-windows.ahk` in the Startup folder

Alternatively, you can compile the script to an `.exe` file and put that in the Startup folder (see below).

## Build (compile to `.exe`)

This repo includes an npm build script that compiles `src/move-windows.ahk` to `dist/move-windows.exe` and sets the icon.

Prerequisites:

- AutoHotkey v2 installed (includes the compiler `Ahk2Exe.exe` in typical installs)
- Node.js (only needed for the build script)

Build:

```bash
npm run build
```

## Customization

You can modify the keyboard shortcuts by editing `src/move-windows.ahk`.

See the [AutoHotKey v2 documentation](https://www.autohotkey.com/docs/v2/) for hotkey syntax.

## Troubleshooting

- **Script not working**: Make sure AutoHotKey is installed and the script is running (check system tray for the green "H" icon)
- **Window doesn't move**: Some windows (like system dialogs) cannot be moved programmatically
- **Single monitor**: The script requires at least 2 monitors to function
