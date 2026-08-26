#!/bin/bash
# PreToolUse hook (Bash matcher): block dangerous git operations wherever they
# appear in the command string, so wrappers like `git -C <dir> ...`, `sh -c "..."`,
# pipes, and `&&` chains cannot slip past prefix-based permission rules.

input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
[ -z "$cmd" ] && exit 0

deny() {
  jq -cn --arg reason "$1" \
    '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$reason}}'
  exit 0
}

has() { printf '%s' "$cmd" | grep -Eq "$1"; }

# token boundaries: not preceded/followed by alnum, "_" or "-"
B='(^|[^[:alnum:]_-])'
E='([^[:alnum:]_-]|$)'

if has "${B}reset${E}" && has "${B}--hard${E}"; then
  deny "ブロック: reset --hard (破壊的操作)"
fi
if has "${B}push${E}" && { has "${B}--force(-with-lease)?${E}" || has "${B}-f${E}"; }; then
  deny "ブロック: force push"
fi
if has "${B}branch${E}" && has "${B}-D${E}"; then
  deny "ブロック: branch -D (強制削除)"
fi
if has "${B}clean${E}" && has "${B}-f[a-zA-Z]*${E}"; then
  deny "ブロック: clean -f (未追跡ファイル削除)"
fi
if has "${B}worktree${E}" && has "${B}remove${E}"; then
  deny "ブロック: worktree remove"
fi
if has "${B}checkout[[:space:]]+(--[[:space:]]+)?\\.${E}"; then
  deny "ブロック: checkout . (変更破棄)"
fi

# commit メッセージへの Claude/Anthropic 系文言の混入を常時 deny（permit フラグの有無に関係なく効く）
if has "${B}commit${E}" && printf '%s' "$cmd" | grep -Eqi 'claude|anthropic|co-authored-by|generated with'; then
  deny "ブロック: commit に Claude/Anthropic 系の文言を含めることは禁止されています。"
fi

exit 0
