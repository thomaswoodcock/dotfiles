# Install Visual Studio Code extensions
code --install-extension dbaeumer.vscode-eslint
code --install-extension eamodio.gitlens
code --install-extension esbenp.prettier-vscode
code --install-extension ms-vscode.powershell
code --install-extension pkief.material-icon-theme
code --install-extension zhuangtongfa.material-theme

# Link config files
New-Item -ItemType SymbolicLink -Path "${env:USERPROFILE}\.gitconfig" -Value ".\.gitconfig" -Force
New-Item -ItemType SymbolicLink -Path "${env:APPDATA}\Code\User\settings.json" -Value ".\vscode.settings.json" -Force
