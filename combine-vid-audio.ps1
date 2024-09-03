param (
    [Parameter(Position = 0, Mandatory = $true)]
    [string]$videoFile,

    [Parameter(Position = 1, Mandatory = $true)]
    [string]$audioFile,

    [Parameter(Position = 2)]
    [string]$outputFile = "combined.mp4"
)

# Ensure ffmpeg is available in the PATH
$ffmpegPath = "ffmpeg"
if (-not (Get-Command $ffmpegPath -ErrorAction SilentlyContinue)) {
    Write-Error "ffmpeg is not installed or not available in PATH."
    exit 1
}

# Run the ffmpeg command to combine video and audio
$command = "$ffmpegPath -i `"$videoFile`" -i `"$audioFile`" -map 0:v:0 -map 1:a:0 -c copy `"$outputFile`""
Invoke-Expression $command

Write-Host "Video and audio have been successfully combined into $outputFile"

