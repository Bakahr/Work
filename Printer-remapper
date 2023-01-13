#Printer & Driver Reset Tool

# This script deletes all network printers and their drivers, then re-install the printers while retaining the default printer.
# the list of printers is backed up to C:\Temp\PrinterList.txt for reference in case of any issues. 

#  Must be run as local admin.  Run from Windows Terminal or PowerShell ISE as Administrator.

#  This script is provided as-is with no warranty or support.  Use at your own risk.

# this script only works for windows 10 / 11 and properly 8/8.1.  It will not work for windows 7 or earlier.

#  This script is based on the following article: https://www.bleepingcomputer.com/news/microsoft/microsoft-releases-tool-to-reset-printer-drivers-in-windows-10/
# The location for the prndrvr.vbs script, which is used to manipulate the printer drivers, it's in a different location depending on the OS version.

$prndrvrPath = "C:\Windows\System32\Printing_Admin_Scripts\en-US\prndrvr.vbs"
$ComputerOSVersion = Get-WmiObject -Class Win32_OperatingSystem | Select-Object Version

# init Arrays
$PrinterList = @()
$DriverList = @()

# Output path to text file
$Path = "C:\Temp\"

# Create the directory if the path doesn't exist
if (!(Test-Path $Path)) {
    New-Item -ItemType Directory -Force -Path $Path | Out-Null
}

# Determine Default Printer
$DefaultPrinter = Get-DefaultPrinter | Where-Object {$_.Default -eq $true }

# Get list of network Printers
$NetworkPrinters = Get-Printer -ConnectionName * -ErrorAction SilentlyContinue | Select-Object Name, DriverName, PortName, ConnectionName | Sort-Object Name | Where-Object {$_.ConnectionName -eq $true}

# Loop through the list of network printers and add them to the array
foreach ($Printer in $NetworkPrinters) {
    # Save Printer names into PrinterList array
    $PrinterList += $Printer.Name

    # Save Driver names into DriverList array
    $DriverList += $Printer.DriverName
}

# Remove duplicate entries from the DriverList array
$DriverList = $DriverList | Get-Unique
$Printerlist = $Printerlist | Get-Unique


# Create a list of all Printers seperated onto new lines
$PrinterListText = $PrinterList -join "`n"

# Save list of printers to text file (for reference in case of any issues)
$PrinterList | Out-File -FilePath "$Path\PrinterList.txt" -Encoding ASCII -Force

Add-Content -Path "$Path\PrinterList.txt" -Value " 
Default Printer:
$DefaultPrinter

Printers:
$PrinterListText"

# List printers on screen
Write-Host "    "
Write-Host "Default Printer:" -ForegroundColor Green
Write-Host $DefaultPrinter.Name
Write-host ""
Write-host "Printers:" -ForegroundColor
Write-Host $PrinterListText

Divider

# Remove all network printers
Write-Host "Removing all network printers..." -ForegroundColor Red
Get-Printer -ConnectionName * -ErrorAction SilentlyContinue | Remove-Printer -Force | Where-Object {$_.ConnectionName -eq $true} | ForEach-Object {$_.Delete()}

# Remove all Network Printer Drivers
foreach ($Driver in $DrierList) {
    # Stop the print spooler service
    Stop-Service -Name Spooler -Force
    Start-Sleep 2

    # Clear local Printer cache
    Remove-Item -Path "C:\Windows\System32\Spool\PRINTERS\*" -Force -Recurse -ErrorAction SilentlyContinue

    # Restart the print spooler service
    Start-Service -Name Spooler -Force
    Start-Sleep 2

    # Delete Printer Drivers
    if($ComputerOSVersion.Version.StartsWith(10)) {
        # Windows 10
        Write-Host "Deleting $Driver" -ForegroundColor Red -NoNewline
        Write-host $Driver
        Invoke-Expression "cscript.exe $prndrvrPath -d -m -n `"$Driver`" -v 3 -e`"Windows x64`""
    } elseif($ComputerOSVersion.Version.StartsWith(6.3)) {
        # Windows 8.1
        cscript.exe $prndrvrPath -d -m -n $Driver
    } elseif($ComputerOSVersion.Version.StartsWith(6.2)) {
        # Windows 8
        cscript.exe $prndrvrPath -d -m -n $Driver
    } else {
        # Windows 7 or earlier
        Write-Host "This script is not supported on Windows 7 or earlier.  Please upgrade your Operating System instead" -ForegroundColor Red
        break
    }
}

# Re-install network printers
ForEach($Printer in $PrinterList) {
    Write-Host "Readding " -ForegroundColor Green -NoNewline
    Write-Host $Printer
    Add-Printer -Name $Printer -ConnectionName $Printer
}

Write-Host "   "

# Set Default Printer
Write-Host "Setting Default Printer..." -ForegroundColor Green
$DefaultPrinter.SetAsDefaultPrinter() | Out-Null 

Write-Host "   "
Write-Host "Done!"
Pause
