# Work


Collection of Powershell scripts, automation tools and more.




FixUserSHellFolderPermissions.ps1  solves all the problems in one go without need for Elevated Privileges, use it first before manually running the 3 other scripts..
_________________________________________________________________________________________________________________________________________________________________________
This helper Diagnostic script from Microsoft Support is aimed to fix corrupt registry permissions of HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders

Usage:

Fix (if needed) your current user profile: .\FixUserShellFolderPermissions.ps1
Force the registration main Shell packages: .\FixUserShellFolderPermissions.ps1 -register
Force the registration of every packages (might take long time): .\FixUserShellFolderPermissions.ps1 -force
[Run As Admin] Attempt to recover every profiles, but won't register packages .\FixUserShellFolderPermissions.ps1 -allprofiles
To accept the EULA and run the tool silently: .\FixUserShellFolderPermissions.ps1 -accepteula
It is provided AS IS, no support nor warranty of any kind is provided for its usage.
