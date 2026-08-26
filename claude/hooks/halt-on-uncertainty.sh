#!/bin/bash
# PreToolUse hook: 直近のユーザー発言以降に「不明点や独自判断：」を
# 「なし」以外で申告した状態でのツール実行を deny する。
# 「申告したら質問して停止し、ユーザーの回答を待つ」を機械的に強制する。

input=$(cat)
tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -n "$tp" ] && [ -f "$tp" ] || exit 0

# 最後の「本物のユーザー発言」(tool_result を含まない user エントリ)以降の
# assistant テキストを連結して取り出す
texts=$(jq -rs '
  [ .[] | select(.type=="user" or .type=="assistant") ] as $es
  | ([ $es | to_entries[]
      | select(.value.type=="user")
      | select([.value.message.content[]? | select(.type=="tool_result")] | length == 0)
      | select((.value.message.content | type) == "string"
               or ([.value.message.content[]? | select(.type=="text")] | length > 0))
      | .key ] | last) as $lu
  | if $lu == null then "" else
      ([ $es[($lu+1):][] | select(.type=="assistant")
         | .message.content[]? | select(.type=="text") | .text ] | join("\n"))
    end
' "$tp" 2>/dev/null)
[ -z "$texts" ] && exit 0

bad=$(printf '%s' "$texts" | grep "不明点や独自判断：" | grep -cvE "不明点や独自判断：[[:space:]]*なし")
if [ "${bad:-0}" -gt 0 ]; then
  jq -cn '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:"「不明点や独自判断」を申告した状態でのツール実行は禁止です。ユーザーに質問し、不明点や独自判断がない状態になるよう努めてください。"}}'
fi
exit 0
