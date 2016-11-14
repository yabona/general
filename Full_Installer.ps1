# YABONES 2016 REPRESENT

# Group array
$groupNames = @("Customer Service","Executive", "Field Service", "Finance", 
    "Human Resources (HR)", "Information Technology", "Management", "Marketing", 
    "Operations & Planning", "Programming & Development", "Purchasing", 
    "Quality Assurance", "Sales", "Shipping & Receiving")

# Group setup
new-adorganizationalunit -name DistGroups
ForEach ($i in $groupNames) {
	New-ADGroup -name $i -path "OU=DistGroups,DC=Litware,DC=com" -GroupCategory Distribution -GroupScope Universal 
}

# Dump AD users, sort by desc, pipe desc to group membership
Get-ADUser -SearchBase "OU=Accounts,DC=Litware,DC=com" -filter * -properties "Description" `
    | Select SamAccountName, Description `
    | ForEach-Object `
        {Add-ADGroupMember -Identity $_.Description -Members $_.SAMAccountName}

# Create and setup allstaff group, add admin account
New-ADGroup -Name "All Staff" -path "OU=DistGroups,DC=Litware,DC=com" `
    -GroupCategory Distribution -GroupScope Universal
Add-ADGroupMember -Identity "All Staff" -Members ExAdmin

# Add staff dist groups to allstaff
ForEach ($i in $groupNames)  {
    Add-ADGroupMember -Identity "All Staff" -Members $i
}

# Enable AllStaff in Exchange
Enable-DistributionGroup -Identity "All Staff"

# Enable all distibutionGroups in Exchange
Foreach ($i in $groupNames) {
    Enable-DistributionGroup -Identity $i
}

