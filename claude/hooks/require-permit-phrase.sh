#!/bin/bash
# Stop hook: 許可を求める応答は固定文「許可いただけますか？ (y/n)」で聞かせる。
# 許可要求と見なせる言い回しがあるのに固定文を欠く場合は decision:block で書き直させる。

input=$(cat)

# 書き直しループ防止
active=$(printf '%s' "$input" | jq -r '.stop_hook_active // false')
[ "$active" = "true" ] && exit 0

tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -n "$tp" ] && [ -f "$tp" ] || exit 0

text=$(jq -rs '[.[] | select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text] | last // empty' "$tp")
[ -z "$text" ] && exit 0

PHRASE='許可いただけますか？ (y/n)'
printf '%s' "$text" | grep -qF "$PHRASE" && exit 0

# 許可を求めている言い回し
if printf '%s' "$text" | grep -Eq 'y *(を)?(ください|下さい)|許可(を)?(ください|下さい|いただ)|よいですか|いいですか|してよいか|進めますか|実行しますか|しますか？'; then
  jq -cn --arg r "許可を求める時は固定文「${PHRASE}」で聞いてね。言い回しを変えずに、最終行をその文にして書き直して。" \
    '{decision:"block", reason:$r}'
fi
exit 0
