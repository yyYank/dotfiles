#!/bin/bash
# PreToolUse(Bash): 直近のユーザー発言に「許可」が無い間は、Bash 経由の gh / git 書き込み系を
# 機械的に deny する（edit-permit-gate.sh と同じフラグを共有。読み取り系は許可不要）。

input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
[ -z "$cmd" ] && exit 0

flag="/tmp/claude-edit-permit"
if [ -f "$flag" ]; then
  exit 0
fi

deny() {
  jq -cn --arg reason "$1" \
    '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$reason}}'
  exit 0
}

has() { printf '%s' "$cmd" | grep -Eq "$1"; }

# token boundaries: not preceded/followed by alnum, "_" or "-"
B='(^|[^[:alnum:]_-])'
E='([^[:alnum:]_-]|$)'

# gh: 読み取り系（list/view/status/diff/checks、auth status、version/help）以外は deny
if has "${B}gh${E}"; then
  if ! has "${B}gh[[:space:]]+[a-z-]+[[:space:]]+(list|view|status|diff|checks)${E}" \
     && ! has "${B}gh[[:space:]]+auth[[:space:]]+status${E}" \
     && ! has "${B}gh[[:space:]]+(--version|--help|help)${E}"; then
    deny "直近のユーザー発言に「許可」が無いため gh の書き込み系コマンドは実行できない。内容を提示して許可を求めること。"
  fi
fi

# git: 書き込み系サブコマンドを deny（status/diff/log/show 等の読み取りは通す）
GIT_WRITE='(commit|push|merge|rebase|cherry-pick|revert|am|apply|reset|restore|switch|checkout|clean|mv|filter-branch|update-ref|symbolic-ref|gc|prune|tag)'
if has "${B}git${E}" && has "${B}${GIT_WRITE}${E}"; then
  deny "直近のユーザー発言に「許可」が無いため git の書き込み系コマンドは実行できない。内容を提示して許可を求めること。"
fi
if has "${B}git${E}" && has "${B}stash${E}" && ! has "${B}stash[[:space:]]+(list|show)${E}"; then
  deny "直近のユーザー発言に「許可」が無いため git stash の書き込み系は実行できない。"
fi
if has "${B}git${E}" && has "${B}branch${E}" && has "${B}(-d|-D|-m|-M|--delete|--move)${E}"; then
  deny "直近のユーザー発言に「許可」が無いため git branch の変更操作は実行できない。"
fi
if has "${B}git${E}" && has "${B}remote${E}" && has "${B}(add|remove|rm|rename|set-url)${E}"; then
  deny "直近のユーザー発言に「許可」が無いため git remote の変更操作は実行できない。"
fi

exit 0
