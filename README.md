# Office365 Business Email Compromise

This is a basic PowerShell script that can be used when an Office 365 user is compromised. It will do the following:

Install the AzureAD module needed to run the necessary commands.
Import the AzureAD module
Prompt the user to enter the tenand ID and store it in a variable for later use
Prompt the user to enter the email address of the compromised user and store it in a variable for later use
Revoke session tokens for the user using the tenant ID
Asks if you want to block the user from signing in and do so if you answer yes
Ask for the user's new password and then reset it to the given password
Get all forwarding rules for that user's mailbox then print them so you can see if there is anything suspicious
Check inbox rules on the account then print them to the screen so you can see if there is anything suspicious
Unblock the user's account
