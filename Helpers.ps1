function SyncVsCodeExtensions {
    param(
        [string[]] $extensions
    )

    $installedExtensions = code --list-extensions

    $unlistedExtensions = $installedExtensions | Where-Object { $_ -notin $extensions }

    foreach ($extension in $unlistedExtensions) {
        Write-Host "Removing '$extension' ... " -NoNewline
        code --uninstall-extension $extension | Out-Null
        Write-Host "Done!"
    }

    $missingExtensions = $extensions | Where-Object { $_ -notin $installedExtensions }

    foreach ($extension in $missingExtensions) {
        Write-Host "Installing '$extension' ... " -NoNewline
        code --install-extension $extension | Out-Null
        Write-Host "Done!"
    }
}

function CreateSymbolicLinks {
    param(
        [string[][]] $symbolicLinks
    )

    $missingLinks = @()

    foreach($link in $symbolicLinks) {
        $target = Resolve-Path $link[1]

        if (-not(Test-Path -Path $link[0])) {
            $missingLinks += @{ from = $link[0]; to = $target }
            continue
        }

        $isSymbolic =  ((Get-Item $link[0]).Attributes.ToString() -match "ReparsePoint")

        if (-not($isSymbolic)) {
            $missingLinks += @{ from = $link[0]; to = $target }
            continue
        }

        $existingTarget = Get-Item -Path $link[0] | Select-Object -ExpandProperty Target

        if ($target.Path -ne $existingTarget) {
            $missingLinks += @{ from = $link[0]; to = $target }
        }
    }

    foreach ($symbolicLink in $missingLinks) {
        Write-Host "Creating link from '$($symbolicLink.from)' to '$($symbolicLink.to)' ... " -NoNewline
        New-Item -ItemType SymbolicLink -Path $symbolicLink.from -Value $symbolicLink.to -Force | Out-Null
        Write-Host "Done!"
    }
}
