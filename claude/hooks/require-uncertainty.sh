#!/bin/bash
# Stop hook: 最終応答が所定の5セクション形式を満たしていなければ
# decision:block で書き直しを強制する。
# 必須セクション: プロンプトへの回答／結論／理由／その他／不明点や独自判断

input=$(cat)

# 書き直しループ防止(既に Stop hook 起因で継続中なら素通し)
active=$(printf '%s' "$input" | jq -r '.stop_hook_active // false')
[ "$active" = "true" ] && exit 0

tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -n "$tp" ] && [ -f "$tp" ] || exit 0

text=$(jq -rs '[.[] | select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text] | last // empty' "$tp")
[ -z "$text" ] && exit 0

missing=""
for section in "プロンプトへの回答：" "結論：" "理由：" "その他：" "不明点や独自判断："; do
  if ! printf '%s' "$text" | grep -qF "$section"; then
    missing="${missing}${section} "
  fi
done

if [ -n "$missing" ]; then
  jq -cn --arg r "応答に必須セクションが不足しています: ${missing}。以下の形式で書き直してください。
プロンプトへの回答：（標題化禁止。話者の意図・気持ちを汲み取った応答を書く）
結論：
理由：
その他：
不明点や独自判断：" \
    '{decision:"block", reason:$r}'
fi
exit 0
