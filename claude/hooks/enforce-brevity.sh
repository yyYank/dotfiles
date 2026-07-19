#!/bin/bash
# Stop hook: 最終応答が「箇条書き最大5行・全体200文字以下」を超えていたら
# decision:block で書き直しを強制する。コードブロックは文字数から除外。

input=$(cat)

# 書き直しループ防止(既に Stop hook 起因で継続中なら素通し)
active=$(printf '%s' "$input" | jq -r '.stop_hook_active // false')
[ "$active" = "true" ] && exit 0

tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -n "$tp" ] && [ -f "$tp" ] || exit 0

text=$(jq -rs '[.[] | select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text] | last // empty' "$tp")
[ -z "$text" ] && exit 0

stripped=$(printf '%s' "$text" | sed '/^```/,/^```/d')
chars=$(printf '%s' "$stripped" | tr -d '[:space:]' | wc -m | tr -d ' ')
lines=$(printf '%s' "$stripped" | grep -c .)

if [ "$chars" -gt 200 ] || [ "$lines" -gt 5 ]; then
  jq -cn --arg r "応答が制限超過(${chars}字/${lines}行)。箇条書き最大5行・全体200文字以下で要点のみに書き直すこと。" \
    '{decision:"block", reason:$r}'
fi
exit 0
