# convert-images.ps1

This PowerShell script converts images in a directory or a single image file to WebP format in parallel.

## Parameters

| Parameter | Description |
| --- | --- |
| `-InputPath` | The path to the input directory containing images or a single image file. |
| `-OutputDir` | The path to the directory where the converted WebP files will be saved. It will be created if it doesn't exist. |
| `-Quality` | The quality setting for the WebP conversion (0-100). Lower values mean smaller files but potentially lower quality. Defaults to 50. |
| `-Lossless` | Specifies whether to use lossless WebP compression ($true) or lossy compression ($false). Defaults to $true. |
| `-MaxParallel` | The maximum number of image conversions to run concurrently. Defaults to 10. |

## Description

The script takes advantage of PowerShell's parallel processing capabilities to efficiently convert multiple image files. It supports various input formats including:
- jpg/jpeg
- png
- gif
- bmp
- tiff

The converted files are saved in WebP format, which often provides superior compression while maintaining quality.

## Examples

```powershell
# Convert all images in a directory
./convert-images.ps1 -InputPath .\covers -OutputDir .\covers-webp -Quality 50 -Lossless $true -MaxParallel 10

# Convert a single image
./convert-images.ps1 -InputPath .\my_image.png -OutputDir .\output -Quality 80 -Lossless $false
```

## Requirements

- PowerShell 7.0 or higher (required for ForEach-Object -Parallel)
- ImageMagick must be installed and accessible via the 'magick' command in your PATH
