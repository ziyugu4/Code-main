# PowerShell Script to Clone a GitHub Repository

# Set the URL of the GitHub repository
$repoUrl = "https://github.com/bitprojectspace/Dbryge.git"

# Set the directory to clone to on local
$localDir = "C:\Users\11571\Desktop\ACE"
$repoDir = Join-Path $localDir -ChildPath "Dbryge"

# Check if the target repository directory exists, if so, delete it
if (Test-Path $repoDir) {
    Remove-Item -Path $repoDir -Recurse -Force
    Write-Host "Existing repository directory removed: $repoDir"
}

# Check if the target directory exists, if not, create it
if (-not (Test-Path $localDir)) {
    New-Item -ItemType Directory -Path $localDir
}

# Change to target directory
Set-Location $localDir

# Clone repository
git clone $repoUrl

# Print completion message
Write-Host "Repository cloned to $repoDir"
