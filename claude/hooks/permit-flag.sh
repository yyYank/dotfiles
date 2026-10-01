#!/bin/bash
# UserPromptSubmit: ユーザー発言の原文が「y」「ok」「許可」の完全一致の時だけ編集許可フラグを置く。
# モデルの解釈を介在させない機械的判定。フラグは発言ごとに置き直す(許可は直近発言のみ有効)。

input=$(cat)
prompt=$(printf '%s' "$input" | jq -r '.prompt // ""')
# フラグは session 単位。全セッション共通にすると他セッションの発言で立つ/消えるため unsafe。
# 副作用: サブエージェントは別 session_id になるので編集ツールは deny される。
sid=$(printf '%s' "$input" | jq -r '.session_id // "unknown"')
flag="/tmp/claude-edit-permit-${sid}"

log="/tmp/claude-permit.log"
# 許可語は完全一致のみ: y / ok / 許可（大文字 OK は不許可）
norm=$(printf '%s' "$prompt" | tr -d '[:space:]')
case "$norm" in
  y|ok|許可) touch "$flag"; act=touch ;;
  *) rm -f "$flag"; act=remove ;;
esac
printf '%s permit-flag %s prompt=%.20s\n' "$(date +%FT%T)" "$act" "$norm" >> "$log"
exit 0
