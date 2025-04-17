# Setting up my OS

## General

Make sure to backup saves. On windows, use [GameSave Manager](https://www.gamesave-manager.com/), but also check for [cross-platform alternatives](https://alternativeto.net/software/gamesave-manager/), such as [Game Backup Monitor](http://mikemaximus.github.io/gbm-web/index.html) or [Ludusavi](https://github.com/mtkennerly/ludusavi).

Ensure VSCode backups correctly. Open the command palette and search for `Settings Sync: Show Synced Data`.

Make sure firefox sync backed up recently.

## Linux

- **Arch**: Before installing the new OS, backup the packages installed with `pacman -Qe > pkgs` or `pacman -Qqe > pkgs` for output without version.
- **Fedora**: `dnf list`.
- **Homebrew**: `brew bundle dump` and `brew bundle install`.

Some non-explicitly installed packages (dependencies maybe?) get on the list, so some manual work for re-installing is required.

### System config

Check [this](https://www.reddit.com/r/linuxquestions/comments/r9w8yh/comment/hnk0ybc/) on how to make F-keys work as F-keys.

Don't forget to `ssh-add` all required keys and check they work correctly with `seahorse`.

```sh
sudo timedatectl set-local-rtc 1
systemctl --user restart pipewire.service # Apply null sync source
```

Add a custom shortcut for `gnome-system-monitor`.

Open `gnome-tweaks`:

- Disable mouse middle click paste
- Startup applications: `thunderbird`, `discord`, `qpwgraph`

Check this [wiki entry](https://wiki.manjaro.org/index.php/Configure_NVIDIA_(non-free)_settings_and_load_them_on_Startup) if there is any issue with graphics.

### Terminal

```sh
ln ~/.dotfiles/.zshrc ~
ln ~/.dotfiles/.tmux.conf ~
ln ~/.dotfiles/.config/starship.toml ~/.config/starship.toml
# The next two can be found in the package manager, but just in case
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source .tmux.conf
# Tmux Prefix + I
```

### Tools

```sh
# JS
volta install node
volta install pnpm
# Moon
curl -fsSL https://moonrepo.dev/install/moon.sh | bash
# Python
curl https://pyenv.run | bash
# Check available versions and pick last
pyenv install --list
pyenv install <version>
pyenv global <version>
which python # Check if it was correctly added to the environment
python -m pip install -U pipx
pipx install ansible-core poetry git-sim mprof
# Rust
curl https://sh.rustup.rs -sSf | sh
# Others
curl -sSf https://atlasgo.sh | sh
```

#### Path

Take a look on [arch wiki page for environment variables](https://wiki.archlinux.org/title/Environment_variables) on how to add directories to path in different situations.

For now, I just add volta (node) to solve [vscode-jest#741](https://github.com/jest-community/vscode-jest/issues/741).

```sh
echo 'export VOLTA_HOME="$HOME/.volta"' >> ~/.profile
echo 'export PATH="$VOLTA_HOME/bin:$PATH"' >> ~/.profile
```

### Completions

```sh
pnpm install-completion zsh
moon completions > ~/.config/tabtab/zsh/moon.zsh
echo '[[ -f ~/.config/tabtab/zsh/moon.zsh ]] && . ~/.config/tabtab/zsh/moon.zsh || true' >> ~/.config/tabtab/zsh/__tabtab.zsh
k3d completion zsh > ~/.config/tabtab/zsh/k3d.zsh
echo '[[ -f ~/.config/tabtab/zsh/k3d.zsh ]] && . ~/.config/tabtab/zsh/k3d.zsh || true' >> ~/.config/tabtab/zsh/__tabtab.zsh
```

Check [catpuccin theme for gnome terminal](https://github.com/catppuccin/gnome-terminal).

### Gnome extensions

- [Color Picker](https://extensions.gnome.org/extension/3396/color-picker/).
- [Firefox PiP Always on Top](https://extensions.gnome.org/extension/5306/firefox-pip-always-on-top/).
- [Just Perfection](https://extensions.gnome.org/extension/3843/just-perfection/).
- [Hanabi](https://github.com/jeffshee/gnome-ext-hanabi).
- [Tray Icons: Reloaded](https://extensions.gnome.org/extension/2890/tray-icons-reloaded/).
  - Tray icons limit: 5
  - Icon size: 16
  - Spacing - Tray Margin: 4 0
  - Spacing - Icon Margin: 0 2
  - Spacing - Icon Padding: 0 6
- Dash to dock:
  - Position and Size -> Intelligent autohide ->  -> 󱋭 Enable in fullscreen mode
  - Launchers -> 󱋭 Isolate monitors
  - Behavior -> Click action -> Focus, minimize or show previews
- GSConnect
- [Fullscreen Avoider](https://extensions.gnome.org/extension/4362/fullscreen-avoider/).
- Custom Accent Colors
- [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/).

### Others

- Thunderbird

  Install `EDS Calendar Integration` and `KeepRunning` addons.

- Themes:
  - [catppuccin/gtk](https://github.com/catppuccin/gtk).
  - [Catppuccin GTK Theme](https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme/).

### Workarounds

In case some webview based apps fail to render, using the `WEBKIT_DISABLE_DMABUF_RENDERER=1` environment may work. If it does, check if modesetting is enabled

```sh
cat /sys/module/nvidia_drm/parameters/modeset
```

If it prints `N`, enable it and restart

```sh
echo options nvidia_drm modeset=1 | sudo tee /etc/modprobe.d/nvidia_drm.conf
```

## Windows

Install [posh-cli](https://github.com/bergmeister/posh-cli) and [starship](https://starship.rs/). Make sure starship command is the last one.

To create [Symbolic Links](https://winaero.com/create-symbolic-link-windows-10-powershell/) for important files, run this on an elevated powershell prompt:

```pwsh
New-Item -ItemType SymbolicLink -Path "~/.gitconfig" -Target ".dotfiles/.gitconfig"

New-Item -ItemType SymbolicLink -Path "~/.gitconfig-windows" -Target ".dotfiles/.gitconfig-windows"
```

Also check [Multiple SSH Keys settings for different github account](https://gist.github.com/jexchan/2351996)

Before installing chocolatey, I run `New-Item -ItemType SymbolicLink -Path "C:/ProgramData/chocolatey" -Target "D:/ProgramData/chocolatey"` to save space on C drive

To install [chocolatey](https://docs.chocolatey.org/en-us/choco/setup) run

```pwsh
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Then run `choco install Packages.config` which can be generated with ChocolateyGUI, that can be installed with `choco install chocolateygui`

To personalize the terminal:

```pwsh
mkdir .config
New-Item -ItemType SymbolicLink -Path "~/.config/starship.toml" -Target "../.dotfiles/starship.toml"
```

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
|                                 |                    D:\\msys64\\scripts |
|                                 |     C:\\Program Files\\PowerShell\\7\\ |
| PLATFORMIO_CORE_DIR             |           D:\\ProgramData\\.platformio |
| PLATFORMIO_SETTING_PROJECTS_DIR | D:\Juano\Documents\Projects\PlatformIO |

I install `pyenv` using chocolatey. After this, install `pipx`, and using pipx, install `poetry` and `git-sim`.
