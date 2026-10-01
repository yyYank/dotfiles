#!/bin/bash
# PreToolUse(Edit|Write|NotebookEdit): 直近のユーザー発言に「許可」が無ければ編集を機械的にdenyする。

input=$(cat)
# フラグは session 単位(permit-flag.sh と対応)
sid=$(printf '%s' "$input" | jq -r '.session_id // "unknown"')
flag="/tmp/claude-edit-permit-${sid}"

log="/tmp/claude-permit.log"
if [ -f "$flag" ]; then
  printf '%s edit-gate allow\n' "$(date +%FT%T)" >> "$log"
  exit 0
fi
printf '%s edit-gate deny\n' "$(date +%FT%T)" >> "$log"

jq -cn '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:"直近のユーザー発言に「y / ok / 許可」の文言が無いため編集ツールは使用できません。作業内容を提示して「許可していただけますか？」と依頼してください。"}}'
exit 0
