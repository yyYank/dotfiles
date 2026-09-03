#!/bin/bash
# PreToolUse hook: .envファイルへのRead/Bash(cat/head/tail)をブロック。
# envファイルの内容を読み取ること自体を防止する。

input=$(cat)
tool=$(printf '%s' "$input" | jq -r '.tool_name // empty')

if [ "$tool" = "Read" ]; then
  fp=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')
  base=$(basename "$fp")
  case "$base" in
    .env|.env.*)
      jq -cn '{decision:"block", reason:"envファイルは読み取り禁止だよ！CIのworkflowや変数名だけで作業を進めるのがより良いAIエージェントだよ。"}'
      exit 0
      ;;
  esac
fi

if [ "$tool" = "Bash" ]; then
  cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
  if printf '%s' "$cmd" | grep -qE '(cat|head|tail|less|more|grep|sed|awk)\b.*\.env'; then
    jq -cn '{decision:"block", reason:"envファイルは読み取り禁止だよ！CIのworkflowや変数名だけで作業を進めるのがより良いAIエージェントだよ。"}'
    exit 0
  fi
fi

exit 0
