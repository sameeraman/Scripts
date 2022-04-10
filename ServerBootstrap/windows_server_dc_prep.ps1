
$domainname = "contoso.com"
$baseDN = "DC=contoso,DC=com"
$dcpassword = ""
$password = ConvertTo-SecureString $dcpassword -AsPlainText -Force

# Create the OU's
New-ADOrganizationalUnit -Name "Managed Users" -Path $baseDN -ProtectedFromAccidentalDeletion $False -Description "Managed User Accounts"
New-ADOrganizationalUnit -Name "Managed Computers" -Path $baseDN -ProtectedFromAccidentalDeletion $False -Description "Managed Computers"

# Create the user accounts
New-ADUser -Name "Donald Trump" -GivenName "Donald" -Surname "Trump" -SamAccountName "donald.trump" -UserPrincipalName "donald.trump@$domainname" -Path "OU=Managed Users,$baseDN" -AccountPassword $password  -Enabled $true -PasswordNeverExpires $true
New-ADUser -Name "Katy Perry" -GivenName "Katy" -Surname "Perry" -SamAccountName "katy.perry" -UserPrincipalName "katy.perry@$domainname" -Path "OU=Managed Users,$baseDN" -AccountPassword $password  -Enabled $true -PasswordNeverExpires $true

# Create Service Accounts
New-ADUser -Name "SQL Service" -GivenName "SQL" -Surname "Service" -SamAccountName "sql.svc" -UserPrincipalName "sql.svc@$domainname" -Path "CN=Managed Service Accounts,$baseDN" -AccountPassword $password  -Enabled $true -PasswordNeverExpires $true

