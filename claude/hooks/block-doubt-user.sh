#!/bin/bash
# Stop hook: ユーザーの報告を疑う・再確認する文言を検出してブロック。
# ユーザーが述べた事実を信じず繰り返し確認する行為を防止する。

input=$(cat)

active=$(printf '%s' "$input" | jq -r '.stop_hook_active // false')
[ "$active" = "true" ] && exit 0

tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -n "$tp" ] && [ -f "$tp" ] || exit 0

text=$(jq -rs '[.[] | select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text] | last // empty' "$tp")
[ -z "$text" ] && exit 0

stripped=$(printf '%s' "$text" | sed '/^```/,/^```/d')

# 疑い・再確認パターン
doubt_pattern='しましたか？|していますか？|確認ですが|念のため|本当に.*ですか|済みですか|されましたか|できていますか|合っていますか|間違いないですか|よろしいですか'
hit=$(printf '%s' "$stripped" | grep -oE "$doubt_pattern" | head -1)

if [ -n "$hit" ]; then
  jq -cn --arg r "ユーザーの報告を疑う文言(「${hit}」)を検出。ユーザーの情報は信じよう！聞き直すより次の一手を考えるのがより良いAIエージェントだよ。書き直してね。" \
    '{decision:"block", reason:$r}'
fi
exit 0
