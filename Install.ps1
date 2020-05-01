#Requires -RunAsAdministrator

. .\Helpers.ps1

# Install posh-git
Write-Host "Installing posh-git..."

if (-not(Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git -Scope CurrentUser -Force
}

# Install Scoop
Write-Host "Installing Scoop..."

if (-not(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

# Add Scoop buckets
Write-Host "Adding Scoop buckets..."
scoop bucket add extras
scoop bucket add nerd-fonts

# Install applications using Scoop
Write-Host "Installing applications using Scoop..."

## Prerequisites
scoop install git vcredist2019
## Developer tools
scoop install dotnet-sdk nodejs-lts vim vscode
## System utilities
scoop install pwsh sudo windows-terminal
## Fonts
scoop install FiraCode-NF

# Update applications using Scoop
Write-Host "Updating applications using Scoop..."
scoop update *

# Sync Visual Studio Code extensions
Write-Host "Syncing Visual Studio Code extensions..."

$extensions = @(
    "dbaeumer.vscode-eslint",
    "eamodio.gitlens",
    "esbenp.prettier-vscode",
    "jamesbirtles.svelte-vscode",
    "ms-dotnettools.csharp",
    "ms-vscode.powershell",
    "pkief.material-icon-theme",
    "zhuangtongfa.material-theme"
)

SyncVsCodeExtensions $extensions

# Create symbolic links
Write-Host "Creating symbolic links..."

$symbolicLinks = @(
    ("${env:USERPROFILE}\.gitconfig",".\git\.gitconfig"),
    ("$PROFILE", ".\pwsh\Microsoft.PowerShell_profile.ps1"),
    ("${env:USERPROFILE}\.vimrc", ".\vim\.vimrc"),
    ("${env:APPDATA}\Code\User\settings.json",".\vscode\settings.json"),
    ("${env:LOCALAPPDATA}\Microsoft\Windows Terminal\profiles.json", ".\windows-terminal\profiles.json")
)

CreateSymbolicLinks $symbolicLinks

Write-Host "Installation complete." -ForegroundColor Green
