## Required Verification / 検証コマンド（必須）
- Before declaring completion, always run exactly these commands from repo root.
- 完了を宣言する前に、必ず以下のコマンドをリポジトリルートで実行すること。

- Python: pytest -q
- JS/TS: npm run lint && npm run typecheck && npm test
- Go: go test ./...

- If a command is missing, state "verification command not found" and stop.
- コマンドが存在しない場合、「verification command not found」と明記して停止すること。