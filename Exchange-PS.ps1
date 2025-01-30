Add-MailboxPermission -Identity "xxx@example.com" -User "xxx@example.com" -AccessRights FullAccess -InheritanceType All

Add-RecipientPermission -Identity "xxx@example.com" -Trustee "xxx@example.com" -AccessRights SendAs1

Remove-MailboxPermission -Identity "xxx@example.com" -User "xxx@example.com" -AccessRights FullAccess -InheritanceType All
