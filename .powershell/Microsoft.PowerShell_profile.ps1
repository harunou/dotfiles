# vim:set et sw=2:

. "$HOME\.powershell\functions.ps1"

Import-Module git-aliases -DisableNameChecking

# Shell hotkeys emulation
Set-PSReadlineOption -EditMode Emacs

# Additional keybindings
Set-PSReadLineKeyHandler -Chord 'Ctrl+i' -Function Complete
Set-PSReadLineKeyHandler -Key Tab -Function Complete

# Reload the shell
Set-Alias reload Reload-Powershell

# Basic path aliases
Set-PathAliases -aliases @{
  "~" = "~";
  ".." = "..";
  "..." = "..\..";
}


$localProfile = "$HOME\.powershell\profile.local.ps1"

if (Test-Path $localProfile) {
  . $localProfile
}

