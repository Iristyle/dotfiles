function Delete-VMHost($name)
{
  curl -X DELETE -H X-AUTH-TOKEN:${ENV:VMPOOLER_TOKEN} --url http://vcloud.delivery.puppetlabs.net/vm/$name
}

$modules = 'posh-git', 'oh-my-posh'

function Install-ModuleDependencies()
{
  $modules | % { if (-not (Get-Module $_)) { Install-Module $_ -AcceptLicense -Force } }
}

function Update-ModuleDependencies()
{
  Install-ModuleDependencies
  $modules | % { Update-Module $_ -AcceptLicense -Force }
}

import-module $modules
Set-Theme Paradox

import-module PSReadLine
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# rustup completions
. ./rustup.ps1
