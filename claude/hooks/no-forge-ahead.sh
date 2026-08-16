#!/bin/bash
# Stop hook: 最終応答に着手宣言(「進めます」等)が含まれていたら decision:block で
# 「進める許可をもらえますか？」という許可依頼形への書き直しを強制する。
# コードブロック内は検査対象から除外。

input=$(cat)

# 書き直しループ防止(既に Stop hook 起因で継続中なら素通し)
active=$(printf '%s' "$input" | jq -r '.stop_hook_active // false')
[ "$active" = "true" ] && exit 0

tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -n "$tp" ] && [ -f "$tp" ] || exit 0

text=$(jq -rs '[.[] | select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text] | last // empty' "$tp")
[ -z "$text" ] && exit 0

stripped=$(printf '%s' "$text" | sed '/^```/,/^```/d')

pattern='進めます|実装します|続けます|着手します|再開します|進めていきます|作業を始めます'
hit=$(printf '%s' "$stripped" | grep -oE "$pattern" | head -1)

if [ -n "$hit" ]; then
  jq -cn --arg r "着手宣言(「${hit}」)は禁止。宣言を削除し、着手したい場合は『進める許可をもらえますか？』という許可依頼の形に書き直すこと。許可を得るまで実装・編集ツールを実行しない。" \
    '{decision:"block", reason:$r}'
fi
exit 0
