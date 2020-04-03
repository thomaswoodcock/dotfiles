#Requires -RunAsAdministrator

. .\Helpers.ps1

# Install Scoop
Write-Host "Installing Scoop..."

if (-not(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

# Add Scoop buckets
Write-Host "Adding Scoop buckets..."
scoop bucket add extras

# Install applications using Scoop
Write-Host "Installing applications using Scoop..."
scoop install git vscode windows-terminal

# Update applications using Scoop
Write-Host "Updating applications using Scoop..."
scoop update *

# Sync Visual Studio Code extensions
Write-Host "Syncing Visual Studio Code extensions..."

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
Write-Host "Creating symbolic links..."

$symbolicLinks = @(
    ("${env:USERPROFILE}\.gitconfig",".\.gitconfig"),
    ("${env:APPDATA}\Code\User\settings.json",".\vscode.settings.json"),
    ("${env:LOCALAPPDATA}\Microsoft\Windows Terminal\profiles.json", ".\windows-terminal.profiles.json")
)

CreateSymbolicLinks $symbolicLinks

Write-Host "Installation complete." -ForegroundColor Green
