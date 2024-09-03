$sourcePath = "C:\Users\Laura\Downloads"
$destinationPath = "F:\Moved_Downloads"
$today = Get-Date
$limit = $today.AddDays(-2)  # 48 hours ago

# Get all files in the source directory that are older than the specified limit
$filesToMove = Get-ChildItem -Path $sourcePath | Where-Object { $_.LastWriteTime -lt $limit }

# Create the destination directory if it doesn't exist
if (!(Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath | Out-Null
}

# Move each file to the destination directory
foreach ($file in $filesToMove) {
    Move-Item -Path $file.FullName -Destination $destinationPath -Force
}
