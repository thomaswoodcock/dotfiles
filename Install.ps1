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

Write-Host "Syncing Visual Studio Code extensions..." -ForegroundColor Yellow
SyncVsCodeExtensions $extensions

# Create symbolic links
$symbolicLinks = @(
    ("${env:USERPROFILE}\.gitconfig",".\.gitconfig"),
    ("${env:APPDATA}\Code\User\settings.json",".\vscode.settings.json")
)

Write-Host "Creating symbolic links..." -ForegroundColor Yellow
CreateSymbolicLinks $symbolicLinks

Write-Host "Installation complete." -ForegroundColor Green
