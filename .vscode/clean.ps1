$ErrorActionPreference = "SilentlyContinue"

$root = Split-Path -Parent $PSScriptRoot

$patterns = @(
    "*.aux",
    "*.bbl",
    "*.bcf",
    "*.blg",
    "*.fdb_latexmk",
    "*.fls",
    "*.log",
    "*.out",
    "*.run.xml",
    "*.synctex.gz",
    "*.toc"
)

foreach ($pattern in $patterns) {
    Get-ChildItem -Path $root -Recurse -File -Filter $pattern | ForEach-Object {
        Remove-Item -LiteralPath $_.FullName -Force
    }
}

Get-ChildItem -Path $root -Recurse -File -Filter "*.eps" | ForEach-Object {
    $pdfPath = [System.IO.Path]::ChangeExtension($_.FullName, ".pdf")
    if (Test-Path -LiteralPath $pdfPath) {
        Remove-Item -LiteralPath $pdfPath -Force
    }
}

Get-ChildItem -Path $root -Recurse -File -Filter "*-eps-converted-to.pdf" | ForEach-Object {
    Remove-Item -LiteralPath $_.FullName -Force
}
