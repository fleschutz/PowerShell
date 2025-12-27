# PowerShell Commander

A modern dark-themed GUI for managing and running PowerShell scripts.

![CustomTkinter](https://img.shields.io/badge/CustomTkinter-5.2+-blue)
![Python](https://img.shields.io/badge/Python-3.8+-green)

## Features

- **Dark Modern UI**: Built with CustomTkinter for a sleek, modern interface
- **Category Organization**: Scripts organized into Files, Computer, Network, Audio, Apps, Dev, Utils, and Custom categories
- **Script Manager**: Add/remove scripts from categories through a visual interface
- **Interactive Scripts**: Full support for scripts that require user input via dialog boxes
- **Output Console**: Real-time script output display with scrolling
- **Script Dump Folder**: Store all your scripts in one place, then pick which ones to show in the GUI
- **Windows Startup**: Auto-launch when Windows starts

## Installation

### Prerequisites

- PowerShell 5.1+ (Windows) or PowerShell Core (Linux/macOS)

### Quick Start

1. Make sure Python 3.8 or higher is installed, e.g. by executing: `winget install "Python 3.9"`

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Run the application:
   ```bash
   python powershell_commander.py
   ```

### Windows Auto-Start

To make PowerShell Commander start with Windows:

1. Run `install_startup.bat`
2. Done! The app will now launch when Windows starts

To remove from startup:
- Run `uninstall_startup.bat`

## Usage

### Categories

- **Files**: File and folder operations (create, delete, zip, convert)
- **Computer**: System monitoring (CPU, RAM, drives, processes)
- **Network**: Network tools (DNS, ping, VPN, WiFi)
- **Audio**: Sound controls (volume, text-to-speech, play audio)
- **Apps**: Application management (open, close, install)
- **Dev**: Development tools (Git operations, build, clean)
- **Utils**: Utilities (weather, news, hash, screenshot)
- **Custom**: Your personal scripts

### Managing Scripts

1. Click **"Manage Scripts"** in the header
2. Search for scripts in the left panel
3. Select a category from the dropdown
4. Click **"Add"** to add a script to the category
5. Click **"Remove"** to remove a script from a category

### Adding Custom Scripts

1. Place your `.ps1` scripts in the `script_dump` folder
2. Open Script Manager
3. Find your script and add it to the desired category
4. Edit `config/scripts_config.json` to customize display name, description, and input prompts

### Interactive Scripts

For scripts that require user input, configure them in `scripts_config.json`:

```json
{
  "name": "my-script",
  "display_name": "My Script",
  "description": "Does something cool",
  "requires_input": true,
  "input_prompts": [
    {
      "name": "path",
      "label": "Enter Path",
      "placeholder": "C:\\path\\to\\folder",
      "default": ""
    }
  ]
}
```

## Configuration

The main configuration file is `config/scripts_config.json`. You can:

- Add/remove categories
- Customize category icons and descriptions
- Configure which scripts appear in each category
- Set up input prompts for interactive scripts
- Adjust window size and scripts per row

## File Structure

```
gui/
├── powershell_commander.py   # Main application
├── requirements.txt          # Python dependencies
├── start_commander.bat       # Windows launcher
├── install_startup.bat       # Add to Windows startup
├── uninstall_startup.bat     # Remove from startup
├── config/
│   └── scripts_config.json   # Category/script configuration
└── script_dump/              # Custom scripts folder
```

## Keyboard Shortcuts

- **Enter**: Submit input dialogs
- **Escape**: Cancel input dialogs

## Troubleshooting

### "Python not found"
Install Python from https://python.org and ensure it's added to PATH.

### "customtkinter not found"
Run: `pip install customtkinter`

### Scripts not running
- Ensure PowerShell execution policy allows scripts
- Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

## License

CC0 - Public Domain
