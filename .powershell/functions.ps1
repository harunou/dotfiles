# vim:set et sw=2:

# Add path aliases
function Set-PathAliases {
  param (
    [hashtable]$aliases
  )

  foreach ($entry in $aliases.GetEnumerator()) {
    $alias = $entry.Name
    $path = $entry.Value

    # Define the function dynamically
    Invoke-Expression "function global:$alias { Set-Location `"$path`" }"
  }
}


# Reload the Shell
function Reload-Powershell {
  wt -w 0 new-tab powershell -NoLogo
  exit
}

# Adjust prompt to add a branch name if inside of a git repo
function prompt {
    $esc = [char]27 # ESC character for VT sequences
    $resetColor = "${esc}[0m"
    $base = "PS"
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $branchName = Get-BranchName

    Write-Host -NoNewline "$base $path"

    if ($branchName) {
      Write-Host -NoNewline " (" -ForegroundColor Magenta
      Write-Host -NoNewline "git" -ForegroundColor White
      Write-Host -NoNewline ")-[" -ForegroundColor Magenta
      Write-Host -NoNewline "$branchName" -ForegroundColor Green
      Write-Host -NoNewline "]" -ForegroundColor Magenta
    }

    Write-Host -NoNewline "> " -ForegroundColor White

    # Return the actual prompt symbol, ensuring it's reset to default color
    return "${resetColor}"
}

function Get-BranchName {
    try {
        # Capture both stdout and stderr of the git command
        $branch = & git rev-parse --abbrev-ref HEAD 2>&1

        # Check if the output indicates we're not in a git repository
        if ($branch -like "*fatal: not a git repository*") {
            return $null
        }

        if ($branch -eq "HEAD") {
            # We're probably in detached HEAD state, return the SHA
            $branch = & git rev-parse --short HEAD 2>&1
            return $branch
        }
        else {
            # We're on an actual branch, return the branch name
            return $branch
        }
    } catch {
        # If any error occurs, assume not in a git repository or any other
        # error
        return $null
    }
}

