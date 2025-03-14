$sourcePath = "C:\Users\ctimm_lokal\Second-Brain\🌿 Projekte\posts"
$destinationPath = "C:\Users\ctimm_lokal\blog\content\posts"

$myRepo = "git@github.com:hackinister/blog.git"

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $ScriptDir

$requireCommands = @('git')

foreach ($cmd in $requireCommands) {
  if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
    Write-Error "$cmd is not installed or not in PATH."
    exit 1
  }
}

if (-not (Test-Path ".git")) {
  Write-Host "Initializing Git repository..."
  git init
  git remote add origin $myRepo
} else {
  Write-Host "Git repository already initialized."
  $remotes = git remote
  if (-not ($remotes -contains 'origin')) {
    Write-Host "Adding remote origin..."
    git remote add origin $myRepo
  }
}

Write-Host "Syncing posts from Obsidian..."

if(-not (Test-Path $sourcePath)){
  Write-Error "Source path does not exist: $sourcePath"
  exit 1
}

if (-not (Test-Path $destinationPath)) {
  Write-Error "Destination path does not exist: $destinationPath"
  exit 1
}

$robocopyOptions = @('/MIR', '/Z', '/W:5', '/R:3')
$robocopyResult = robocopy $sourcePath $destinationPath @robocopyOptions

if ($LASTEXITCODE -ge 8) {
  Write-Error "Robocopy failed with exit code $LASTEXITCODE"
  exit 1
}

Write-Host "Processing image links in Markdown files..."
if (-not (Test-Path "images2blog.exe")) {
  Write-Error "Go Programm images2blog.exe not found."
  exit 1
}

try {
  & .\images2blog.exe
}catch {
  Write-Error "Failed to process image links."
  exit 1
}

Write-Host "Staging changes for Git..."
$hasChanges = (git status --porcelain) -ne ""
if (-not $hasChanges) {
  Write-Host "No changes to stage."
} else {
  git add .
}

$commitMessage = "New Blog Post on $(Get-Date -Format 'dd-MM-yyyy HH:mm:ss')"
$hasStagedChanges = (git diff --cached --name-only) -ne ""
if (-not $hasStagedChanges) {
  Write-Host "No changes to commit."
} else {
  Write-Host "Committing changes..."
  git commit -m "$commitMessage"
}

Write-Host "Deploying to GitHub Main..."
try {
  git push origin main
} catch {
  Write-Error "Failed to push to main branch."
  exit 1
}



