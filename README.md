Install [posh-cli](https://github.com/bergmeister/posh-cli) and [starship](https://starship.rs/). Make sure starship command is the last one.

To create [Symbolic Links](https://winaero.com/create-symbolic-link-windows-10-powershell/) for important files, run this on an elevated powershell prompt:

```
New-Item -ItemType SymbolicLink -Path "~/.gitconfig" -Target ".dotfiles/.gitconfig"

New-Item -ItemType SymbolicLink -Path "~/.gitconfig-windows" -Target ".dotfiles/.gitconfig-windows"
```

Also check [Multiple SSH Keys settings for different github account](https://gist.github.com/jexchan/2351996)

Before installing chocolatey, I run `New-Item -ItemType SymbolicLink -Path "C:/ProgramData/chocolatey" -Target "D:/ProgramData/chocolatey"` to save space on C drive

To install [chocolatey](https://docs.chocolatey.org/en-us/choco/setup) run

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Then run `choco install Packages.config` which can be generated with ChocolateyGUI, that can be installed with `choco install chocolateygui`

To personalize the terminal, run `mkdir .config` and `New-Item -ItemType SymbolicLink -Path "~/.config/starship.toml" -Target "../.dotfiles/starship.toml"`

In order to add [ssh](https://docs.github.com/es/github/authenticating-to-github/connecting-to-github-with-ssh/about-ssh) support, OpenSSH service must be enabled in `services.msc`. On windows, [some config](https://gist.github.com/danieldogeanu/16c61e9b80345c5837b9e5045a701c99) must be changed in order to enable the ssh auth `git config --system core.sshCommand C:/Windows/System32/OpenSSH/ssh.exe`. Also, check [this](https://dev.to/rafaelcpalmeida/managing-multiple-git-configurations-1gdh) for multiple git configurations.

After updating MSYS2, some changes are needed. First, create a Hard Link from MSYS2 home directory to Windows home directory `New-Item -ItemType SymbolicLink -Path "D:/msys64/home/JuanoD" -Target "C:/Users/JuanoD"` and `New-Item -ItemType SymbolicLink -Path 'D:\msys64\scripts' -Target "${pwd}/scripts"`.
Make sure to check [git-for-windows inside MSYS2](https://github.com/git-for-windows/git/wiki/Install-inside-MSYS2-proper).

Set var `LC_ALL=C.UTF-8` to render all characters correctly. Read [this](https://stackoverflow.com/questions/41139067/git-log-output-encoding-issues-on-windows-10-cli-terminal) for info.

Some changes I make to environment variables

| Variable                        |                                 Change |
| ------------------------------- | -------------------------------------: |
| MSYS2_ROOT                      |                             D:\\msys64 |
| Path                            |                                    `+` |
|                                 |               D:\\Programs\VSCode\\bin |
|                                 |               D:\\msys64\\mingw64\\bin |
|                                 |                   D:\\msys64\\usr\\bin |
|                                 |             D:\\msys64\\scripts |
|                                 |     C:\\Program Files\\PowerShell\\7\\ |
| PLATFORMIO_CORE_DIR             |           D:\\ProgramData\\.platformio |
| PLATFORMIO_SETTING_PROJECTS_DIR | D:\Juano\Documents\Projects\PlatformIO |

I install `pyenv` using chocolatey. After this, install `pipx`, and using pipx, install `poetry` and `git-sim`.