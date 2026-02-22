#!/bin/bash
# update tmux status cache with ccusage session data

OUTPUT=$(npx ccusage blocks --json --active --token-limit 45000 2>/dev/null)

if [ -z "$OUTPUT" ]; then
    exit 0
fi

echo "$OUTPUT" | python3 -c "
import sys, json, re
from datetime import datetime

data = json.load(sys.stdin)
blocks = data.get('blocks', [])
active = [b for b in blocks if b.get('isActive')]
if not active:
    sys.exit(0)

b = active[-1]
models = b.get('models', ['unknown'])
model = [m for m in models if not m.startswith('<')][-1] if any(not m.startswith('<') for m in models) else 'unknown'
model = model.replace('claude-', '')
model = re.sub(r'-\d{8}$', '', model)

tokens = b.get('totalTokens', 0)
limit = b.get('tokenLimitStatus', {}).get('limit', 45000)
tokens_str = f'{tokens // 1000}k/{limit // 1000}k' if tokens >= 1000 else f'{tokens}/{limit // 1000}k'
cost = b.get('costUSD', 0)
now = datetime.now().strftime('%m/%d %H:%M')

print(f'{model} | {tokens_str} | \${cost:.2f} | {now}')
" > ~/.cache/claude-status.txt 2>/dev/null
