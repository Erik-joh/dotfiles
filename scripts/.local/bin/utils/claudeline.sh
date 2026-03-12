#!/usr/bin/env bash

input=$(cat)

# Tokyo Night colors (24-bit)
BLUE=$'\033[38;2;122;162;247m'    # #7aa2f7 - repo name
YELLOW=$'\033[38;2;224;175;104m'  # #e0af68 - git branch
GREEN=$'\033[38;2;158;206;106m'   # #9ece6a - tokens
DIM=$'\033[38;2;86;95;137m'       # dimmed separators
RESET=$'\033[0m'

repo=$(echo "$input" | python3 -c "
import json, sys
data = json.load(sys.stdin)
cwd = data.get('workspace', {}).get('current_dir', '') or data.get('cwd', '')
parts = cwd.rstrip('/').split('/')
print(parts[-1] if parts else '')
" 2>/dev/null)

branch=$(echo "$input" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(data.get('git', {}).get('branch', ''))
" 2>/dev/null)

# Fallback: get branch directly from git if not in JSON
if [[ -z "$branch" ]]; then
  cwd=$(echo "$input" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(data.get('workspace', {}).get('current_dir', '') or data.get('cwd', ''))
" 2>/dev/null)
  branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)
fi

tokens=$(echo "$input" | python3 -c "
import json, sys
data = json.load(sys.stdin)
cw = data.get('context_window', {})
# Try multiple possible field names
used = cw.get('tokens_used') or cw.get('used') or 0
total = cw.get('tokens_total') or cw.get('total') or cw.get('size') or 0
pct = cw.get('used_percentage') or cw.get('usage_percentage') or 0
if total:
    k = used // 1000
    tk = total // 1000
    print(f'{k}k/{tk}k ({pct:.0f}%)')
elif pct:
    print(f'{pct:.0f}%')
" 2>/dev/null)

parts=()
[[ -n "$repo" ]]   && parts+=("${BLUE} ${repo}${RESET}")
[[ -n "$branch" ]] && parts+=("${DIM}on${RESET} ${YELLOW} ${branch}${RESET}")
[[ -n "$tokens" ]] && parts+=("${DIM}·${RESET} ${GREEN}󰯉 ${tokens}${RESET}")

printf '%s' "$(IFS=' '; echo "${parts[*]}")"
