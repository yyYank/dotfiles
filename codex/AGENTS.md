# AGENTS.md

## Rules

以下のルールファイルを参照してください。

- [default.rules](rules/default.rules) — コマンドの自動許可ルール
- [workflow.md](rules/workflow.md) — コミット・プッシュ・ブランチ操作のワークフロールール
- [release-artifacts.md](rules/release-artifacts.md) — リリース成果物に関するルール
- [tdd.md](rules/tdd.md) — TDD方法論のガイダンス
- [tidy-first.md](rules/tidy-first.md) — Tidy Firstアプローチ

## 開発原則

**TDDとTidy Firstを必ず遵守すること。**

- TDDサイクルを厳守する：Red → Green → Refactoring
- 構造的変更と振る舞いの変更を同じコミットに混在させない
- テストをパスさせるために必要最小限のコードのみを書く
- 詳細は [tdd.md](rules/tdd.md) と [tidy-first.md](rules/tidy-first.md) を参照
