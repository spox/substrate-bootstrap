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

Write-Host "Downloading Windows Build Tools."
$WebClient.DownloadFile($BuildToolsURL, $BuildToolsDestination)
Write-Host "Windows Build Tools successfully downloaded."
Write-Host "Downloading Wix toolset."
$WebClient.DownloadFile($WixURL, $WixDestination)
Write-Host "Wix toolset successfully downloaded."
Write-Host "Downloading puppet installation powershell script."
$WebClient.DownloadFile($PuppetInstallURL, $PuppetInstallDestination)
Write-Host "Puppet installation powershell script successfully downloaded."

$BuildToolsInstallArgs = @("/NoRefresh", "/NoRestart", "/NoWeb", "/Quiet", "/Full")
Write-Host "Installing Windows Build Tools."
$BuildToolsProcess = Start-Process -FilePath $BuildToolsDestination -ArgumentList $BuildToolsInstallArgs -Wait -PassThru

if ($BuildToolsProcess.ExitCode -ne 0) {
  Write-Host "Failed to install Windows Build Tools."
  Exit 1
}
Write-Host "Windows Build Tools successfully installed."


$WixInstallArgs = @("/quiet", "/norestart")
Write-Host "Installing Wix toolset."
$WixProcess = Start-Process -FilePath $WixDestination -ArgumentList $WixInstallArgs -Wait -PassThru

if ($WixProcess.ExitCode -ne 0) {
  Write-Host "Failed to install Wix Toolset."
  Exit 1
}
Write-Host "Wix toolset successfully installed."

Write-Host "Starting puppet installation script."
Invoke-Expression $PuppetInstallDestination