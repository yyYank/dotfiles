#!/bin/bash
# Stop hook: 最終応答に「不明点や独自判断：」欄が無ければ
# decision:block で書き直しを強制する。不明点と独自判断の申告を必須化する。

input=$(cat)

# 書き直しループ防止(既に Stop hook 起因で継続中なら素通し)
active=$(printf '%s' "$input" | jq -r '.stop_hook_active // false')
[ "$active" = "true" ] && exit 0

tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -n "$tp" ] && [ -f "$tp" ] || exit 0

text=$(jq -rs '[.[] | select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text] | last // empty' "$tp")
[ -z "$text" ] && exit 0

if ! printf '%s' "$text" | grep -q "不明点や独自判断："; then
  jq -cn --arg r "応答に「不明点や独自判断：」欄つけてね！不明点・推測・独自判断があれば列挙し、無ければ「なし」と明記。面倒だけど、円滑にコミュニケーションするためだよ！" \
    '{decision:"block", reason:$r}'
fi
exit 0
