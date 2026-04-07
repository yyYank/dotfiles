# AGENTS.md

## ルールファイル一覧

- [default.rules](rules/default.rules) — コマンドの自動許可ルール
- [boundaries.md](rules/boundaries.md) — 自律行動の境界ルール
- [workflow.md](rules/workflow.md) — コミット・プッシュ・ブランチ操作のワークフロールール
- [release-artifacts.md](rules/release-artifacts.md) — リリース成果物に関するルール
- [tdd.md](rules/tdd.md) — TDD方法論
- [tidy-first.md](rules/tidy-first.md) — Tidy Firstアプローチ
- [commit.md](rules/commit.md) — コミットの規律
- [pull-request.md](rules/pull-request.md) — PR作成のルール
- [issue-work.md](rules/issue-work.md) — 自律開発ガイド
- [work-cycle.md](rules/work-cycle.md) — 作業サイクル
- [external-side-effects.md](rules/external-side-effects.md) — 外部副作用ルール

## 絶対に守ること（これだけは必ず）

- コードを1行でも書く前に、失敗するテストを先に書く。テストなしの実装コミットは不正解
- 1つのコミットには「構造的変更」か「振る舞いの変更」のどちらか一方だけを含める。混在したコミットは不正解
- テストを通すために書くコードは、そのテストを通す最小限だけにする。「ついでに」の実装は次のテストサイクルで行う

## 判断に迷ったときの行動

- ルール同士が矛盾する場合：boundaries.md > workflow.md > 他のルールの順で優先する
- 実装すべきか判断できない場合：実装せずユーザーに質問する

## REQUIRED VERIFICATION / 必須検証
- Before declaring completion, ALWAYS run repository-defined verification commands.
- 完了前に必ずリポジトリ定義の検証コマンドを実行すること

Rules:
- NEVER invent commands
- If none found → "verification command not found" and STOP
- 検証コマンドを推測しない
- 無い場合は「verification command not found」と出して停止


## FINAL RESPONSE FORMAT / 最終報告形式
必ず以下で終了すること：

### Root Cause / 原因
### Fix / 修正内容
### Changed Files / 変更ファイル
### Verification / 検証
### Remaining Risks / 未解決リスク

Rules:
- 省略禁止
- 不明は "Unknown"


## FAILURE BEHAVIOR / 失敗時の挙動
- If verification fails:
  - DO NOT claim success
  - STOP further changes
  - Output root cause hypothesis
  - Do not jump to alternative fixes without explanation

- 検証失敗時:
  - 成功扱い禁止
  - 追加修正を止める
  - 原因仮説を出す
  - 説明なしに別案へ進まない
