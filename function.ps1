function get-inventory{
param (
$computername = 'localhost',
$drivetype = 3
)
$savefile =$env:USERPROFILE + ‘\Desktop\’ +((Get-Date).ToString(“dd_MM_yyyy_HHmm”))+’.csv’


$disk1 = Get-WmiObject -class Win32_LogicalDisk -computername $computername -filter "drivetype=$drivetype" |Select-Object -property DeviceID,
@{name='FreeSpace(GB)';expression={$_.FreeSpace / 1MB -as [int]}},
@{name='Size(GB)';expression={$_.Size / 1GB -as [int]}},
@{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}


$Report = $disk1 |Export-csv $savefile -NoTypeInformation


}