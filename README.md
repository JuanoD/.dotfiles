To create [Symbolic Links](https://winaero.com/create-symbolic-link-windows-10-powershell/) for important files, run this on an elevated powershell prompt:

`New-Item -ItemType SymbolicLink -Path "~/.gitconfig" -Target ".dotfiles/.gitconfig"`

Before installing chocolatey, I run `New-Item -ItemType SymbolicLink -Path "C:/ProgramData/chocolatey" -Target "D:/ProgramData/chocolatey"` to save space on C drive

To install [chocolatey](https://docs.chocolatey.org/en-us/choco/setup) run

`Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`

Then run `choco install Packages.config` which can be generated with ChocolateyGUI, that can be installed with `choco install chocolateygui`

To personalize the terminal, run `mkdir .config` and `New-Item -ItemType SymbolicLink -Path "~/.config/starship.toml" -Target "../.dotfiles/starship.toml"`

Some changes I make to environment variables

| Variable                        |                                 Change |
| ------------------------------- | -------------------------------------: |
| MSYS_ROOT                       |                             D:\\msys64 |
| Path                            |                                    `+` |
|                                 |               D:\\Programs\VSCode\\bin |
|                                 |               D:\\msys64\\mingw64\\bin |
|                                 |                   D:\\msys64\\usr\\bin |
|                                 |             D:\\ProgramData\\launchers |
|                                 |     C:\\Program Files\\PowerShell\\7\\ |
| PLATFORMIO_CORE_DIR             |           D:\\ProgramData\\.platformio |
| PLATFORMIO_SETTING_PROJECTS_DIR | D:\Juano\Documents\Projects\PlatformIO |
