Get-ADUser -Identity  AMSR -Properties  PwdLastSet, PasswordLastSet, PasswordNeverExpires | Sort-Object Name | Format-Table Name, @{Name='PwdLastSet';Expression={[DateTime]::FromFileTime($_.PwdLastSet)}},PasswordLastSet

Get-ADUser -Identity  XGIPE -Properties PwdLastSet, PasswordLastSet, PasswordNeverExpires | Sort-Object Name | Format-Table Name, PasswordLastSet, PasswordNeverExpires

Get-ADUser -Identity XJEI -Properties LastLogon | Select-Object Name, @{Name='LastLogon';Expression={[datetime]::FromFileTime($_.LastLogon)}}

Get-ADUser -Identity  LSG -Properties AccountExpires | Select-Object name,@{Name="AccountExpires";Expression={[datetime]::FromFileTime($_.properties."AccountExpires")}}
