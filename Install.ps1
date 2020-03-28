#Requires -RunAsAdministrator

. .\Helpers.ps1

# Sync Visual Studio Code extensions
$extensions = @(
    "dbaeumer.vscode-eslint",
    "eamodio.gitlens",
    "esbenp.prettier-vscode",
    "ms-vscode.powershell",
    "pkief.material-icon-theme",
    "zhuangtongfa.material-theme"
)

SyncVsCodeExtensions $extensions

# Create symbolic links
$symbolicLinks = @(
    ("${env:USERPROFILE}\.gitconfig",".\.gitconfig"),
    ("${env:APPDATA}\Code\User\settings.json",".\vscode.settings.json")
)

CreateSymbolicLinks $symbolicLinks
