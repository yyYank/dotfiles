#!/bin/bash
# PostToolUse(AskUserQuestion): 許可ダイアログで「許可する」が選ばれた時だけ編集許可フラグを置く。
# 結果は '"質問"="選んだラベル"' の文字列で渡るため、ラベル完全一致を機械的に判定する。
# permit-flag.sh と同じフラグを共有（次のユーザー発言で置き直される）。

input=$(cat)
flag="/tmp/claude-edit-permit"

resp=$(printf '%s' "$input" | jq -r '[.tool_response | if type=="string" then . else tojson end] | .[0] // ""')

if printf '%s' "$resp" | grep -qF '="許可する"'; then
  touch "$flag"
fi
exit 0
