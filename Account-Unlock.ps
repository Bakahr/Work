# Account Unlock Tool 

# Define function to verify if user is valid
function Test-UserValid($user) {
    $user = Get-ADUser -Identity $user -Properties * -ErrorAction SilentlyContinue
    # Pause if username is not valid
    if ($null -eq $user) {
        Write-Host "User not found in AD. Please try again."
        return $false
    }
    # Proceed if username is valid
    else {
        return $true
    }
}

# set username
$user = Read-Host "Enter the username of the account you wish to unlock"
Write-Host " "

# Verify if user is valid
Test-UserValid


# infinite loop 
while ($true) { 
    #loop 20 times, then clear screen
    while($counter -lt 20) {
        # Pause if username is not valid
        if (Test-UserValid -eq $false) {
            break
        }
        # Proceed if username is valid
        else {
            # Check if account is locked
            $user = Get-ADUser -Identity $user -Properties * -ErrorAction SilentlyContinue
            if ($user.IsAccountLocked -eq $true) {
                # Unlock account
                Unlock-ADAccount -Identity $user
                Write-Host "Account has been unlocked."
                break
            }
            # Pause if account is not locked
            else {
                Write-Host "Account is not locked."
                break
            }
        }
        $counter++
    }
}
