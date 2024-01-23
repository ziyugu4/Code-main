# PowerShell Script to Clone a GitHub Repository and Push Changes

# Navigate to the Desktop
$desktopPath = [Environment]::GetFolderPath('Desktop')
Set-Location -Path $desktopPath

# Set the URL of the GitHub repository
$repoUrl = "https://github.com/bitprojectspace/Dbryge.git"

# Name of the folder to clone to
$repoFolderName = "Dbryge"

# Full path for the new directory on Desktop
$repoDir = Join-Path $desktopPath -ChildPath $repoFolderName

# Check if the target repository directory exists, if so, delete it
if (Test-Path $repoDir) {
    Remove-Item -Path $repoDir -Recurse -Force
    Write-Host "Existing repository directory removed: $repoDir"
}

# Clone repository to Desktop
git clone $repoUrl $repoFolderName

# Change to the cloned repository directory
Set-Location -Path $repoDir

# Add all new and changed files to the staging area
git add .

# Commit the staged files
$commitMessage = "Add cloned files"
git commit -m $commitMessage

# Push the commit to the remote repository
# Replace 'main' with your branch name if it's different
git push origin main

# Print completion message
Write-Host "Repository cloned to $repoDir and changes pushed to remote."
