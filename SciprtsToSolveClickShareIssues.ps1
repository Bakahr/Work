#Run this script first to validate permissions om the registry entries that has "All Application Packages" with "Read" as checked.
$idRef = [System.Security.Principal.SecurityIdentifier]("AC")   
$access = [System.Security.AccessControl.RegistryRights]"ReadKey"
$inheritance = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit,ObjectInherit"
$propagation = [System.Security.AccessControl.PropagationFlags]"None"
$type = [System.Security.AccessControl.AccessControlType]"Allow"
$rule = New-Object System.Security.AccessControl.RegistryAccessRule($idRef,$access,$inheritance,$propagation,$type)

$folder = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
$acl = Get-Acl $folder
try 
{
    $acl.AddAccessRule($rule)
    $acl |Set-Acl
} 
catch { }

$folder = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer'
$acl = Get-Acl $folder
try 
{
    $acl.AddAccessRule($rule)
    $acl |Set-Acl
} catch { }

# Before running these two scripts, open two powershell windows, one with Elevated Privileges and one without.
# Then open Task Manager and kill explorer.exe  script #2 will start the Process again after it's done.

# Run the following in Powershell as Admin (Elevated Privileges)
Get-AppXPackage -AllUsers | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}

# Run this in Powershell, ignore the warnings if you get any.
Get-AppXPackage | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\AppXManifest.xml"}
Get-AppxPackage | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register "C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\AppXManifest.xml"}
Get-AppXPackage | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\AppXManifest.xml"}
if (-not (Get-AppxPackage Microsoft.AAD.BrokerPlugin)) { Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown } Get-AppxPackage Microsoft.AAD.BrokerPlugin
if (-not (Get-AppxPackage Microsoft.Windows.CloudExperienceHost)) { Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown } Get-AppxPackage Microsoft.Windows.CloudExperienceHost

Start-Process explorer.exe


# REMOVE SHITTY  REGEDIT HACK.
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Common\Identity" -Name "EnableADAL"
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Common\Identity" -Name "DisableAADWAM"
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Common\Identity" -Name "DisableADALatopWAMOverride"
cmdkey /list | ForEach-Object{if($_ -like "*Target:*"){cmdkey /del:($_ -replace " ","" -replace "Target:","")}}











#$acl1 = Get-Acl "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders\" #$person = [System.Security.Principal.NTAccount]"all application packages" ##S-1-15-2-1 $sid = New-Object System.Security.Principal.SecurityIdentifier ("S-1-15-2-1") $person_temp = $sid.Translate( [System.Security.Principal.NTAccount]) $person = $person_temp.Value.Split("\")[1] $access = [System.Security.AccessControl.RegistryRights]"ReadKey" $inheritance = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit,ObjectInherit" $propagation = [System.Security.AccessControl.PropagationFlags]"None" $type = [System.Security.AccessControl.AccessControlType]"Allow" $rule = New-Object System.Security.AccessControl.RegistryAccessRule($person,$access,$inheritance,$propagation,$type) $acl1.AddAccessRule($rule) $acl1 | Set-Acl
#if (-not (Get-AppxPackage Microsoft.AAD.BrokerPlugin)) { Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown } Get-AppxPackage Microsoft.AAD.BrokerPlugin
