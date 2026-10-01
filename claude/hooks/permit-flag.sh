#!/bin/bash
# UserPromptSubmit: ユーザー発言の原文が「y」「ok」「許可」の完全一致の時だけ編集許可フラグを置く。
# モデルの解釈を介在させない機械的判定。フラグは発言ごとに置き直す(許可は直近発言のみ有効)。

input=$(cat)
prompt=$(printf '%s' "$input" | jq -r '.prompt // ""')
# サブエージェントは別session_idになるため、フラグは全セッション共通にする(B案)
flag="/tmp/claude-edit-permit"

# 許可語は完全一致のみ: y / ok / 許可（大文字 OK は不許可）
case "$(printf '%s' "$prompt" | tr -d '[:space:]')" in
  y|ok|許可) touch "$flag" ;;
  *) rm -f "$flag" ;;
esac
exit 0
