#!/bin/bash
# update tmux pane-border with ccusage session data

# tmux の外から実行された場合はスキップ
[ -z "$TMUX" ] && exit 0
[ -z "$TMUX_PANE" ] && exit 0

DIR_NAME=$(basename "$PWD")
tmux set -p -t "$TMUX_PANE" @is_claude 1


OUTPUT=$(npx ccusage blocks --json --active --token-limit 45000 2>/dev/null)

if [ -z "$OUTPUT" ]; then
    tmux set -p -t "$TMUX_PANE" @claude_status "#[fg=colour245,bg=colour236] $DIR_NAME #[default]"
    exit 0
fi

RESULT=$(echo "$OUTPUT" | DIR_NAME="$DIR_NAME" python3 -c "
import sys, json, re, os
from datetime import datetime

dir_name = os.environ.get('DIR_NAME', '')

data = json.load(sys.stdin)
blocks = data.get('blocks', [])
active = [b for b in blocks if b.get('isActive')]
if not active:
    if dir_name:
        print(f'#[fg=colour245,bg=colour236] {dir_name} #[default]')
    sys.exit(0)

b = active[-1]
models = b.get('models', ['unknown'])
model = [m for m in models if not m.startswith('<')][-1] if any(not m.startswith('<') for m in models) else 'unknown'
model = model.replace('claude-', '')
model = re.sub(r'-\d{8}$', '', model)

tc = b.get('tokenCounts', {})
tokens = tc.get('inputTokens', 0) + tc.get('outputTokens', 0)
tokens_str = f'{tokens // 1000}k' if tokens >= 1000 else str(tokens)
cost = b.get('costUSD', 0)
now = datetime.now().strftime('%m/%d %H:%M')

dir_seg = f'#[fg=colour245,bg=colour236] {dir_name} ' if dir_name else ''

print(f'#[fg=colour255,bg=colour54] \u26a1{model} #[fg=colour255,bg=colour25] \u25c6 {tokens_str} #[fg=colour255,bg=colour30] \$ {cost:.2f} #[fg=colour250,bg=colour238] \u23f1 {now} {dir_seg}#[default]')
" 2>/dev/null)

if [ -n "$RESULT" ]; then
    tmux set -p -t "$TMUX_PANE" @claude_status "$RESULT"
else
    tmux set -p -t "$TMUX_PANE" @claude_status ""
fi
