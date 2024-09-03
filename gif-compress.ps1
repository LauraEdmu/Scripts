# CompressGif.ps1

param(
    [Parameter(Mandatory=$true)]
    [string]$InputGif
)

# Extract the file name without extension
$FileName = [System.IO.Path]::GetFileNameWithoutExtension($InputGif)

# Define output palette and compressed GIF file names
$Palette = "$FileName-palette.png"
$CompressedGif = "$FileName-compressed.gif"

# Generate palette
ffmpeg -i $InputGif -vf "fps=10,scale=320:-1:flags=lanczos,palettegen" $Palette

# Compress the GIF using the generated palette
ffmpeg -i $InputGif -i $Palette -filter_complex "fps=10,scale=320:-1:flags=lanczos[x];[x][1:v]paletteuse" $CompressedGif

# Clean up the palette file after compression (optional)
Remove-Item $Palette

Write-Output "Compression complete! Compressed GIF saved as $CompressedGif"

