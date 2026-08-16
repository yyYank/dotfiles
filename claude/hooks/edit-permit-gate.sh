#!/bin/bash
# PreToolUse(Edit|Write|NotebookEdit): 直近のユーザー発言に「許可」が無ければ編集を機械的にdenyする。

input=$(cat)
# サブエージェントは別session_idになるため、フラグは全セッション共通にする(B案)
flag="/tmp/claude-edit-permit"

if [ -f "$flag" ]; then
  exit 0
fi

jq -cn '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:"直近のユーザー発言に「許可」の文言が無いため編集ツールは使用できない。作業内容を提示してユーザーの許可を求めること。"}}'
exit 0
