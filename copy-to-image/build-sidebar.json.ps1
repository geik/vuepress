#Requires -PSEdition Core
$pathSeperator = [IO.Path]::DirectorySeparatorChar
$docspath = $args[0]
if(!$docspath) {
    throw "This script takes the full path of the docs directory as its single argument. And yes, it's mandatory."
}

function GetSidebarGroupForDirectory([string]$dir, [int]$level) {
    # links to markdown files; leave out the readme's though, because they're not allowed in links; they're covered by a trailing slash
    $filesSidebarLinks = ( (Get-ChildItem -Path "$dir" -File) | Where-Object { $_.Name -ne "README.md" } | Where-Object { $_.Name -like "*.md" } | ForEach-Object { (GetLink $_.FullName) } )

    # sidebargroups for all subdirs
    $subdirsSidebarGroup = ( (Get-ChildItem -Path "$dir" -Directory -Exclude ".*") | ForEach-Object { (GetSidebarGroupForDirectory $_.FullName ($level + 1)) } | Where-Object {$_} )
    $children = @()
    if ($level -eq 0) {
        $children = @($pathSeperator)
    }
    $children += $filesSidebarLinks
    $children += $subdirsSidebarGroup

    if ($level -eq 0) {
        return $children
    }
    $sidebarGroup = [PSCustomObject]@{ title = (GetTitle $dir); path = (GetLink $dir); collapsable = $true; sidebarDepth = 1; children = $children }
    return $sidebarGroup
}

function GetDir([string]$path) {
    # force a trailing slash
    return ($path.TrimEnd($pathSeperator) + $pathSeperator)
}
function GetTitle([string]$path) {
    $isFile = Test-Path -Path $path -PathType leaf
    $title = ($path.Split($pathSeperator) | Select-Object -Last 1)
    if ($isFile) {
        $title = ($title.Split(".") | Select-Object -First 1)
    }
    $title = (Get-Culture).TextInfo.ToTitleCase($title)
    return $title   
}
function GetLink([string]$pathToFileOrDirectory) {
    $isFile = Test-Path -Path $pathToFileOrDirectory -PathType leaf
    if ($isFile) {
        $linkToFile = $pathToFileOrDirectory.Replace($docspath,"")
        return $pathSeperator + $linkToFile
    }
    $hasReadme = Test-Path -Path $pathToFileOrDirectory$pathSeperator"README.md" -PathType leaf
    if ($hasReadme) {
        $linkToDirectory = $pathToFileOrDirectory.Replace($docspath,"")
        return (GetDir ($pathSeperator + $linkToDirectory))
    }
    return ""
}


$docspath = GetDir $docspath
$sidebarJsonPath = $docspath + ".vuepress" + $pathSeperator + "sidebar.json" 

Write-Host "Generate Vuepress sidebar to" $sidebarJsonPath
Set-Content -Path $sidebarJsonPath -Value ( (GetSidebarGroupForDirectory "$docspath" | ConvertTo-Json -Depth 30 ) )
exit