#!/usr/bin/env bash
# Install the script-to-video-prompts skill for Agent Skills-compatible CLIs.
#
# Usage:
#   ./install.sh                     # all supported tools, personal (global) scope
#   ./install.sh claude qwen         # only the named tools
#   ./install.sh --project           # install into the current project instead
#   curl -fsSL https://raw.githubusercontent.com/Apoorve8055/script-to-video-prompts/main/install.sh | bash
#
# Tools: claude (Claude Code), agents (Codex, Gemini CLI, OpenCode), qwen (Qwen Code)
set -euo pipefail

SKILL="script-to-video-prompts"
REPO="https://github.com/Apoorve8055/script-to-video-prompts.git"

scope="global"
tools=()
for arg in "$@"; do
  case "$arg" in
    --project) scope="project" ;;
    -h|--help) sed -n '2,10p' "$0"; exit 0 ;;
    claude|agents|qwen) tools+=("$arg") ;;
    codex|gemini|opencode) tools+=("agents") ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done
[ ${#tools[@]} -eq 0 ] && tools=(claude agents qwen)

# Use this checkout if the script runs from one; otherwise clone to a temp dir.
src="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"
if [ -z "$src" ] || [ ! -f "$src/SKILL.md" ]; then
  src="$(mktemp -d)"
  trap 'rm -rf "$src"' EXIT
  git clone --depth 1 -q "$REPO" "$src"
fi

if [ "$scope" = "global" ]; then base="$HOME"; else base="$PWD"; fi

installed=()
for tool in $(printf '%s\n' "${tools[@]}" | sort -u); do
  case "$tool" in
    claude) dest="$base/.claude/skills/$SKILL" ;;
    agents) dest="$base/.agents/skills/$SKILL" ;;
    qwen)   dest="$base/.qwen/skills/$SKILL" ;;
  esac
  if [ "$(cd "$src" && pwd)" = "$(mkdir -p "$dest" && cd "$dest" && pwd)" ]; then
    installed+=("$dest (already here)"); continue
  fi
  rm -rf "$dest" && mkdir -p "$dest"
  cp -R "$src/SKILL.md" "$src/references" "$src/LICENSE" "$dest/"
  installed+=("$dest")
done

echo "Installed $SKILL ($scope):"
printf '  %s\n' "${installed[@]}"
echo "Restart your CLI to load the skill."
