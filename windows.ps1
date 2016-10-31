<#
.SYNOPSIS
    Bootstrap the substrate

.DESCRIPTION
    Installs required software and builds substrate
#>

$BuildToolsURL = "https://download.microsoft.com/download/E/E/D/EEDF18A8-4AED-4CE0-BEBE-70A83094FC5A/BuildTools_Full.exe"
$WixURL = "http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=wix&DownloadId=1587179&FileTime=131118854865270000&Build=21031"
$PuppetInstallURL = "https://raw.githubusercontent.com/hashicorp/puppet-bootstrap/master/windows.ps1"

$TmpDir = [System.IO.Path]::GetTempPath()

$BuildToolsDestination = [System.IO.Path]::Combine($TmpDir, "build.exe")
$WixDestination = [System.IO.Path]::Combine($TmpDir, "wix.exe")
$PuppetInstallDestination = [System.IO.Path]::Combine($TmpDir, "puppet.ps1")

$WebClient = New-Object System.Net.WebClient

$WebClient.DownloadFile($BuildToolsURL, $BuildToolsDestination)
$WebClient.DownloadFile($WixURL, $WixDestination)
$WebClient.DownloadFile($PuppetInstallURL, $PuppetInstallDestination)

$BuildToolsInstallArgs = @("/NoRefresh", "/NoRestart", "/NoWeb", "/Quiet", "/Full")
$BuildToolsProcess = Start-Process -FilePath $BuildToolsDestination -ArgumentList $BuildToolsInstallArgs -Wait -PassThru

if ($BuildToolsProcess.ExitCode -ne 0) {
  Write-Host "Failed to install Windows Build Tools."
  Exit 1
}

$WixInstallArgs = @("/quiet", "/norestart")
$WixProcess = Start-Process -FilePath $WixDestination -ArgumentList $WixInstallArgs -Wait -PassThru

if ($WixProcess.ExitCode -ne 0) {
  Write-Host "Failed to install Wix Toolset."
  Exit 1
}

Invoke-Expression $PuppetInstallDestination