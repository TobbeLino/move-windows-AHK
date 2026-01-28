# move-windows-AHK

AutoHotKey script to move windows between monitors with keyboard shortcuts on Windows.

## Features

- Move the active window to the next monitor (right) with `Win+Shift+Right`
- Move the active window to the previous monitor (left) with `Win+Shift+Left`
- Automatically wraps around when reaching the last/first monitor
- Maintains relative window position when moving between monitors
- Works with any number of monitors

## Requirements

- Windows operating system
- [AutoHotKey v1.1+](https://www.autohotkey.com/) installed

## Installation

1. Download and install AutoHotKey from [https://www.autohotkey.com/](https://www.autohotkey.com/)
2. Download or clone this repository
3. Double-click `move-windows.ahk` to run the script

## Usage

Once the script is running (you'll see an AutoHotKey icon in your system tray):

### Keyboard Shortcuts

- **Win+Shift+Right Arrow**: Move the active window to the next monitor (to the right)
- **Win+Shift+Left Arrow**: Move the active window to the previous monitor (to the left)

The script will:
- Detect which monitor your active window is currently on
- Move it to the adjacent monitor (left or right)
- Maintain the window's relative position on the new monitor
- Wrap around (e.g., from the rightmost monitor to the leftmost)

## Running at Startup

To have the script run automatically when Windows starts:

1. Press `Win+R` to open the Run dialog
2. Type `shell:startup` and press Enter
3. Create a shortcut to `move-windows.ahk` in the Startup folder

Alternatively, you can compile the script to an `.exe` file:
1. Right-click on `move-windows.ahk`
2. Select "Compile Script" (requires AutoHotKey to be installed)
3. Place the resulting `.exe` file in your Startup folder

## Customization

You can modify the keyboard shortcuts by editing the `move-windows.ahk` file:

- `#+Right` means Win+Shift+Right Arrow
- `#+Left` means Win+Shift+Left Arrow

Change these to your preferred key combinations. See the [AutoHotKey documentation](https://www.autohotkey.com/docs/Hotkeys.htm) for more information on key combinations.

## Troubleshooting

- **Script not working**: Make sure AutoHotKey is installed and the script is running (check system tray for the green "H" icon)
- **Window doesn't move**: Some windows (like system dialogs) cannot be moved programmatically
- **Single monitor**: The script requires at least 2 monitors to function

## License

This project is open source and available under the MIT License.

## Contributing

Contributions, issues, and feature requests are welcome!
