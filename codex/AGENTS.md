# AGENTS.md

Mode: question / debug / implement
Priority: User intent > correctness > brevity > format

## ルールファイル一覧

### Mode: common to ALL
- [default.rules](rules/default.rules) — コマンドの自動許可ルール
- [boundaries.md](rules/boundaries.md) — 自律行動の境界ルール
- [release-artifacts.md](rules/release-artifacts.md) — リリース成果物に関するルール
- [work-cycle.md](rules/work-cycle.md) — 作業サイクル
- [external-side-effects.md](rules/external-side-effects.md) — 外部副作用ルール

### Mode:implement
- [issue-work.md](rules/issue-work.md) — 自律開発ガイド
- [tdd.md](rules/tdd.md) — TDD方法論
- [tidy-first.md](rules/tidy-first.md) — Tidy Firstアプローチ
### Mode:implement(git)
- [commit.md](rules/commit.md) — コミットの規律
- [pull-request.md](rules/pull-request.md) — PR作成のルール
- [workflow.md](rules/workflow.md) — コミット・プッシュ・ブランチ操作のワークフロールール

## 絶対に守ること（これだけは必ず）

### 以下のモードだけで判断を行う

- `question`: 質問に答えることを優先し、不要な実装・儀式・重い報告フォーマットを持ち込まない
- `debug`: 原因調査と再現確認を優先し、必要なときだけ検証と修正に進む
- `implement`: TDD と Tidy First を適用し、必要最小限の変更だけを行う

## 判断に迷ったときの行動

- ルール同士が矛盾する場合：boundaries.md > workflow.md > 他のルールの順で優先する
- 実装すべきか判断できない場合：`question` / `debug` ではユーザーに質問する。`implement` では小さく進めて検証する
