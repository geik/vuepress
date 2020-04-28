
# on Windows, use capital letter for drive!
$docspath = Resolve-Path ($PSScriptRoot + "\docs")
Write-Host $docspath
. .\copy-to-image\build-sidebar.json.ps1 $docspath
exit