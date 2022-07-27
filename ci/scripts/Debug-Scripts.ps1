param (
    [Parameter(Mandatory = $True)] [String] $Path
)

$RequiredModule = 'PSScriptAnalyzer'
if($Null -eq (Get-Module -Name $RequiredModule)) {
    Write-Host "Installing $RequiredModule"
    Install-Module -Name $RequiredModule -Repository 'PSGallery' -AllowClobber -Scope 'AllUsers' -Force
}

Write-Host "Importing $RequiredModule"
Import-Module -name $RequiredModule -Force

$Result = Invoke-Scriptanalyzer -Path $Path -Recurse
$Result | Format-Table

if($Null -ne $Result) {
    throw "$RequiredModule returned issues."
}
