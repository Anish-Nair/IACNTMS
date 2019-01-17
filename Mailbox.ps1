
function get-mailboxlist
{
 
param(
[parameter(mandatory = $true)]
[string]$identity
)
#$Mailboxes = Import-Csv -Path D:\scripts\mal.csv
foreach($mailbox in $identity)
{$Used = Get-MailboxStatistics -Identity $mailbox
$TotalQuota = Get-Mailbox -Identity $mailbox

$MBX = [pscustomobject] @{
Name = ($used).Displayname;
Created = [string] ($TotalQuota).whencreated;
Valid = ($used).Isvalid;
OU= ($TotalQuota).organizatonalunit
'Total Size' = ($TotalQuota).ProhibitSendReceiveQuota;
'Used Space' = ($Used).TotalItemSize;
Database = ($used).databasename
Hidden = ($TotalQuota).Hiddenfromaddresslistsenabled
'Forward To' = ($TotalQuota).forwardingaddress
#'%Free'= (($used).TotalItemSize / ($TotalQuota).ProhibitSendReceiveQuota) * 100
#'%free' = ('Used space' / 'Total Size') * 100 -as [int]
#'%Free' = @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
}

$MBX | Export-Csv -Path D:\scripts\mailtest.csv -NoTypeInformation
}

}