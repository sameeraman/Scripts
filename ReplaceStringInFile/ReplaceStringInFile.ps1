# This script does a find and replace on a file provided. It also take a backup of the original file. 
param(
    [Parameter()]
    [string]$FilePath,

    [Parameter()]
    [string]$Find,

    [Parameter()]
    [string]$Replace
)


$folderPath = Split-Path -Path $filePath
$filename = Split-Path -Path $filePath -Leaf
$backupfilePathfull = $folderPath + "\" + $filename + "_" + (Get-Date -Format "yyyyMMddTHHmmss")

# Make Backup
Move-Item -Path $filePath -Destination $backupfilePathfull

# recreate the original file
(Get-Content -Path $backupfilePathfull) -replace $find, $replace | Add-Content -Path $filePath

# iis reset
iisreset