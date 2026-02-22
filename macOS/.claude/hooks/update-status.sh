#!/bin/bash
# update tmux status cache with ccusage session data

OUTPUT=$(npx ccusage session --json 2>/dev/null)

if [ -z "$OUTPUT" ]; then
    exit 0
fi

echo "$OUTPUT" | python3 -c "
import sys, json, re

data = json.load(sys.stdin)
sessions = data.get('sessions', [])
if not sessions:
    sys.exit(0)

s = sessions[-1]
models = s.get('modelsUsed', ['unknown'])
model = models[-1] if models else 'unknown'
model = model.replace('claude-', '')
model = re.sub(r'-\d{8}$', '', model)
model = re.sub(r'(-\d+)+$', '', model)

tokens = s.get('totalTokens', 0)
tokens_str = f'{tokens // 1000}k' if tokens >= 1000 else str(tokens)
cost = s.get('totalCost', 0)

print(f'{model} | {tokens_str} | \${cost:.2f}')
" > ~/.cache/claude-status.txt 2>/dev/null
