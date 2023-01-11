#Install AzureAD module
Install-Module AzureAD

#Import the module
Import-Module AzureAD

#Ask for tenant ID from the user
$TenantID = Read-Host -Prompt "Provide Tenant ID"

#Ask for the user's email address
$UserEmail = Read-Host -Prompt "Provide User Email"

#Revoke session tokens for the user using the tenant ID
Revoke-AzureADUserAllRefreshToken -ObjectId $UserEmail -TenantId $TenantID

#Ask do you want to block the user's account from signing in?
$BlockUser = Read-Host -Prompt "Do you want to block the user's account from signing in? (Y/N)"

#If the user wants to block the account, then block it
if ($BlockUser -eq "Y") {
    Set-AzureADUser -ObjectId $UserEmail -AccountEnabled $false
}

#Ask for the user's new password and then reset it to the given password
$NewPassword = Read-Host -Prompt "Provide New Password" -AsSecureString
Reset-AzureADUserPassword -ObjectId $UserEmail -NewPassword $NewPassword

#Get all forwarding rules for that user's mailbox then print them
$ForwardingRules = Get-ForwardingAddress -Identity $UserEmail
$ForwardingRules | Format-Table -Property Name, ForwardingSmtpAddress -AutoSize | Out-Host -Width 200 -ForegroundColor Green -BackgroundColor Black -NoNewline

#Check inbox rules on the account then print them to the screen
$InboxRules = Get-InboxRule -Identity $UserEmail
$InboxRules | Format-Table -Property Name, Enabled, Priority, Condition, Actions -AutoSize | Out-Host -Width 200 -ForegroundColor Green -BackgroundColor Black -NoNewline

#Unblock the user's account
Set-AzureADUser -ObjectId $UserEmail -AccountEnabled $true
