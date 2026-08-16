#!/bin/bash
# UserPromptSubmit: ユーザー発言の原文に「許可」がある時だけ編集許可フラグを置く。
# モデルの解釈を介在させない機械的判定。フラグは発言ごとに置き直す(許可は直近発言のみ有効)。

input=$(cat)
prompt=$(printf '%s' "$input" | jq -r '.prompt // ""')
# サブエージェントは別session_idになるため、フラグは全セッション共通にする(B案)
flag="/tmp/claude-edit-permit"

if printf '%s' "$prompt" | grep -q "許可"; then
  touch "$flag"
else
  rm -f "$flag"
fi
exit 0
