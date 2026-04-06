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
