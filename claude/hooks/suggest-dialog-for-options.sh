#!/bin/bash
# Stop hook: 案を3件以上並べたのに選択ダイアログを出していない応答を block する。
# 3択以上の判断はテキストで並べるより AskUserQuestion の選択式の方が速いため。

input=$(cat)

active=$(printf '%s' "$input" | jq -r '.stop_hook_active // false')
[ "$active" = "true" ] && exit 0

tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -n "$tp" ] && [ -f "$tp" ] || exit 0

text=$(jq -rs '[.[] | select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text] | last // empty' "$tp")
[ -z "$text" ] && exit 0

# 案の列挙を数える: 「案A」「案1」「- A:」「1) 」等
count=$(printf '%s' "$text" | grep -Ec '(^|[^[:alnum:]])案 ?[A-Za-z0-9０-９]|^- *[A-Za-z0-9]+[):：]|^[0-9]+\) ')
[ "${count:-0}" -lt 3 ] && exit 0

# 直近のユーザー発言以降に AskUserQuestion を使っていれば OK
used=$(jq -rs '
  [.[] | select(.type=="user" or .type=="assistant")]
  | (map(.type) | rindex("user")) as $i
  | if $i == null then . else .[$i:] end
  | [.[] | select(.type=="assistant") | .message.content[]? | select(.type=="tool_use") | .name]
  | index("AskUserQuestion") != null
' "$tp")
[ "$used" = "true" ] && exit 0

jq -cn --arg r "案を${count}件並べているよ。3択以上は AskUserQuestion の選択ダイアログで聞いてね。本文は今の内容のまま、選択肢をダイアログにして出し直して。" \
  '{decision:"block", reason:$r}'
exit 0
