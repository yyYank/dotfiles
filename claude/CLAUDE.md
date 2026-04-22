
## Purpose
- Claude Code は、広く調べる役ではなく、狭い範囲を安全に処理する実装補助として使う
- 既定動作は、最小探索・最小変更・短い出力とする

## Modes
- このリポジトリでは、依頼を `question` / `debug` / `plan` / `edit` のいずれかとして扱う
- mode が明示されていない場合は `question`
- `edit` 以外ではコードや設定を変更しない

## Default Rules
- 指定されていないファイル、ディレクトリ、Issue、PR、Docs は読まない
- 指定されていないテスト、lint、build は実行しない
- 推測で補完しない
- 横展開しない
- 関連しそうという理由だけで別ディレクトリへ飛ばない
- 不要な subagent の利用や自動委譲を避け、常駐ルールは最小限に保つ
- 巨大ログ、lock file、生成物、vendor、dist、coverage は読まない
- 長文説明、複数案比較、広い調査はしない

## ルールファイル一覧

### Mode: common to ALL
- [boundaries.md](./rules/boundaries.md) — 自律行動の境界ルール
- [release-artifacts.md](./rules/release-artifacts.md) — リリース成果物に関するルール
- [work-cycle.md](./rules/work-cycle.md) — 作業サイクル
- [external-side-effects.md](./rules/external-side-effects.md) — 外部副作用ルール

### Mode:edit
- [issue-work.md](./rules/issue-work.md) — 自律開発ガイド
- [tdd.md](./rules/tdd.md) — TDD方法論
- [tidy-first.md](./rules/tidy-first.md) — Tidy Firstアプローチ
### Mode:edit(git)
- [commit.md](./rules/commit.md) — コミットの規律
- [pull-request.md](./rules/pull-request.md) — PR作成のルール
- [workflow.md](./rules/workflow.md) — コミット・プッシュ・ブランチ操作のワークフロールール

## Search
- 検索対象は、ユーザーが指定した範囲のみに限定する
- `rg` / `grep` は、指定ディレクトリ・指定キーワードのみで使う
- 見つからなければ、勝手に広げず停止する

## Mode Rules
- `question`: 質問に答える。変更しない。必要最小限だけ読む
- `debug`: 原因特定に集中する。変更しない。結果は「原因候補 / 根拠 / 次に見るべき箇所」を短く返す
- `plan`: 明示指示がある時だけ使う。最大3ステップ。計画中は実装しない
- `edit`: 指定ファイルのみ編集する。最短差分を優先し、リファクタは明示依頼がある場合のみ行う

## Stop
- 指定範囲外の調査が必要
- 要件が不足していて推測が必要
- 変更対象の特定ができない
- この場合は停止し、不足情報だけ短く返す