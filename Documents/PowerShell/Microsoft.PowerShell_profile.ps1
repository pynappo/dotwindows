Unblock-File $profile

oh-my-posh init pwsh --config $HOME/.files/.global/pynappo.omp.json | Invoke-Expression
Import-Module posh-git
Import-Module -Name Terminal-Icons

$env:POSH_GIT_ENABLED = $true

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView


Function Notepad { Notepads @Args } 
Function Dotfiles { 
	if ($Args -and ($Args[0].ToString().ToLower() -eq "link")) {
		if ($Args.Count -ne 3) {"Please supply a link path AND a link target, respectively."}
		else {
			if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
				Return Write-Error("Run as administrator please.")
			}
			if (!(Test-Path $Args[1])) { Return Write-Error("Path invalid.")}
			if (!(Test-Path $Args[2])) { Return Write-Error("Target invalid.")}
			$Path = (Resolve-Path $Args[1]).ToString()
			$Target = (Resolve-Path $Args[2]).ToString()
			
			Move-Item $Path $Target
			$Path = $Path.TrimEnd('\/')
			New-Item -ItemType SymbolicLink -Path $Path -Value ($Target + (Split-Path $Path -Leaf).ToString())
			Dotfiles add $Path
			Dotfiles add $Target
		}
	}
	else { git --git-dir=$Home/.files/ --work-tree=$HOME @Args }
}
Set-Alias -Name df -Value Dotfiles
Function Lazy-Dotfiles { lazygit --git-dir=$Home/.files/ --work-tree=$HOME @Args }
Set-Alias -Name ldf -Value Lazy-Dotfiles

Function Pacup ([string]$Path = "$Home\.files\"){
	scoop export > ($Path + 'scoop.json')
	winget export -o ($Path + 'winget.txt') --accept-source-agreements
}

Function New-Link ($Path, $Target) {
    New-Item -ItemType SymbolicLink -Path $Path -Value $Target 
}
