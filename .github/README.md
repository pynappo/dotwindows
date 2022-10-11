# dotwindows

A set of dotfiles containing most of my Linux and Windows dotfiles. For Windows-exclusive dotfiles, see [dotwindows](https://github.com/pynappo/dotwindows).

# Setup
(assuming git, [scoop](https://github.com/ScoopInstaller/Scoop), and winget are installed):

## Powershell
```
cd $HOME
git clone --bare git@github.com:pynappo/dotfiles.git $HOME/.dotfiles.git/
git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME checkout --force
. $PROFILE
df config status.showUntrackedFiles no
```
# Package lists:
- [scoop.json](.files/scoop.json)
- [winget.json](.files/winget.json)

Import with:
```
scoop install $HOME/.files/scoop.json
winget import -i $HOME/.files/winget.json --accept-package-agreements --accept-source-agreements
```
# Commands
|Command|Description|
|:-|:-:|
|```pacup```|It literally just runs ```scoop export``` and ```winget export``` to the aforementioned package lists.|
