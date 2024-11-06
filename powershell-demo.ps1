
function Get-IPAddress {
    $ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -ne '127.0.0.1' }).IPAddress
    Write-Output "IP Address: $ip"
}

function List-Applications {
    $apps = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName
    Write-Output "Installed Applications:"
    $apps | ForEach-Object { Write-Output $_.DisplayName }
}

function Get-SystemInfo {
    $sysInfo = Get-ComputerInfo
    Write-Output "System Information:"
    Write-Output "OS: $($sysInfo.WindowsVersion)"
    Write-Output "Manufacturer: $($sysInfo.CsManufacturer)"
    Write-Output "Model: $($sysInfo.CsModel)"
    Write-Output "Total Physical Memory: $($sysInfo.CsTotalPhysicalMemory)"
}

function Show-Menu {
    Write-Output "Select an option:"
    Write-Output "1 - Get IP Address"
    Write-Output "2 - List Applications"
    Write-Output "3 - Get System Info"
    Write-Output "4 - Exit"
}

do {
    Show-Menu
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        1 { Get-IPAddress }
        2 { List-Applications }
        3 { Get-SystemInfo }
        4 { Write-Output "Exiting..."; break }
        default { Write-Output "Invalid choice, please try again." }
    }
} while ($choice -ne 4)
