# Install the script-to-video-prompts skill for Agent Skills-compatible CLIs (Windows).
#
# Usage:
#   .\install.ps1                        # all supported tools, personal (global) scope
#   .\install.ps1 -Tools claude,qwen     # only the named tools
#   .\install.ps1 -Project               # install into the current project instead
#   irm https://raw.githubusercontent.com/Apoorve8055/script-to-video-prompts/main/install.ps1 | iex
#
# Tools: claude (Claude Code), agents (Codex, Gemini CLI, OpenCode), qwen (Qwen Code)
param(
    [string[]]$Tools = @('claude', 'agents', 'qwen'),
    [switch]$Project
)
$ErrorActionPreference = 'Stop'

$Skill = 'script-to-video-prompts'
$Repo = 'https://github.com/Apoorve8055/script-to-video-prompts.git'

$aliases = @{ codex = 'agents'; gemini = 'agents'; opencode = 'agents' }
$Tools = $Tools | ForEach-Object { if ($aliases.ContainsKey($_)) { $aliases[$_] } else { $_ } } | Sort-Object -Unique

# Use this checkout if the script runs from one; otherwise clone to a temp dir.
$src = $PSScriptRoot
$temp = $null
if (-not $src -or -not (Test-Path (Join-Path $src 'SKILL.md'))) {
    $temp = Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid())
    git clone --depth 1 -q $Repo $temp
    if ($LASTEXITCODE -ne 0) { throw "git clone failed" }
    $src = $temp
}

$base = if ($Project) { (Get-Location).Path } else { $HOME }
$dirs = @{ claude = '.claude'; agents = '.agents'; qwen = '.qwen' }

$installed = @()
try {
    foreach ($tool in $Tools) {
        if (-not $dirs.ContainsKey($tool)) { throw "Unknown tool: $tool (use claude, agents, codex, gemini, opencode, qwen)" }
        $dest = Join-Path $base (Join-Path $dirs[$tool] "skills\$Skill")
        if ((Resolve-Path $src).Path.TrimEnd('\') -eq $dest.TrimEnd('\')) {
            $installed += "$dest (already here)"; continue
        }
        if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
        New-Item -ItemType Directory -Force $dest | Out-Null
        Copy-Item (Join-Path $src 'SKILL.md'), (Join-Path $src 'LICENSE') $dest
        Copy-Item (Join-Path $src 'references') $dest -Recurse
        $installed += $dest
    }
}
finally {
    if ($temp) { Remove-Item $temp -Recurse -Force -ErrorAction SilentlyContinue }
}

$scope = if ($Project) { 'project' } else { 'global' }
Write-Host "Installed $Skill ($scope):"
$installed | ForEach-Object { Write-Host "  $_" }
Write-Host 'Restart your CLI to load the skill.'
