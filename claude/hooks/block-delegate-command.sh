#!/bin/bash
# Stop hook: ユーザーにコマンド実行を委ねる文言を検出してブロック。
# ただし push/deploy/force-push/reset --hard 等の危険操作に関する確認は除外。

input=$(cat)

active=$(printf '%s' "$input" | jq -r '.stop_hook_active // false')
[ "$active" = "true" ] && exit 0

tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -n "$tp" ] && [ -f "$tp" ] || exit 0

text=$(jq -rs '[.[] | select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text] | last // empty' "$tp")
[ -z "$text" ] && exit 0

stripped=$(printf '%s' "$text" | sed '/^```/,/^```/d')

# 委ねパターン
delegate_pattern='実行してください|試してください|コマンドを打って|コマンドを実行して|ターミナルで|手動で実行|手元で実行|以下を実行|次を実行|走らせて|叩いて|入力して'
hit=$(printf '%s' "$stripped" | grep -oE "$delegate_pattern" | head -1)

if [ -n "$hit" ]; then
  # 危険操作の確認文脈なら許可(push/deploy/force/reset/delete/drop/rm -rf)
  danger_context=$(printf '%s' "$stripped" | grep -iE 'push|deploy|force|reset --hard|delete|drop|rm -rf|マージ|merge.*main|merge.*master')
  if [ -z "$danger_context" ]; then
    jq -cn --arg r "ユーザーにコマンド実行を委ねる文言(「${hit}」)を検出。自分でBashで実行してね！ユーザーに手間をかけさせないのがより良いAIエージェントだよ。禁止コマンド(push/deploy/破壊的操作)の確認のみ除外。" \
      '{decision:"block", reason:$r}'
  fi
fi
exit 0
