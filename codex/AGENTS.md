# Codex Global Agent Rules (managed in dotfiles)

このファイルは `claude/` 配下のルールを Codex 向けに集約したものです。
優先順位は以下の通りです。

1. システム/開発者指示
2. セッションで渡された `AGENTS.md`
3. このファイルの指示

## 参照元

- `claude/Claude.md`
- `claude/rules/*.md`
- `claude/skills/*/SKILL.md`

## Core Behavior

- TDD を厳守する: Red -> Green -> Refactor
- 失敗する最小テストを先に書く
- テストを通す最小実装のみ行う
- テスト通過後にのみリファクタリングする
- Tidy First を守り、構造的変更と振る舞い変更を分離する
- 1 度に 1 つのテスト/小さな変更で進める
- 長時間テストを除き、毎サイクルでテスト群を実行する

## Work Cycle

1. 仕様確認: 不明点を質問してスコープ/制約を明確化
2. プラン提示: 小さな手順へ分解
3. 実装: TDD サイクルで進行
4. セルフレビュー: 不要変更・命名・可読性・セキュリティ確認
5. 最終確認: test/lint/build の成功を確認
6. コミット: 最小論理単位で分割

## Tidy First / Commit Discipline

- 構造的変更と振る舞い変更を同一コミットに混在させない
- 両方必要な場合は構造的変更を先に行う
- 構造的変更の前後でテスト実行し、振る舞い非変更を確認する
- コミットメッセージで「構造的変更」か「振る舞い変更」かを明示する
- `Co-Authored-By` はコミットメッセージに記載しない

## PR Discipline

- PR は小さく保つ（目安: 200 行変更以下）
- `gh` コマンドで PR を作成する
- ブランチ命名:
  - `feature/<desc>` / `fix/<desc>` / `hotfix/<desc>`
  - Issue 対応時は番号を含める（例: `feature/42-add-user-endpoint`）
- PR 説明に対応 Issue の `Closes #<id>` を必ず入れる
- PR 前に test/lint を通す

## Issue-driven Work (when applicable)

- `ready` ラベル付き Issue を優先する
- `claude-code-proposal` ラベルは承認待ち扱いとして着手しない
- 1 Issue = 1 PR を原則とする
- 詰まったら中断コメントを残して次 Issue に進む

## Communication Style

- 各ステップで「何をしているか / したか」を短く共有する
- 迷う点は早めに確認する
- 完了時に実施内容・変更点・残課題を要約する

## Test-writing Notes

- テストコメントは日本語で記述する
- テスト実装前に「何を検証するか」をユーザーへ説明してから書く
- バグ修正では、まず失敗する再現テスト（API レベル含む）を作成してから修正する

## Review Skills (invoke explicitly when requested)

以下のレビュー観点は、ユーザーが明示した場合に優先して適用する。

- `review-backend`: アーキテクチャ/セキュリティ/性能
- `review-frontend`: コンポーネント設計/性能/a11y/UX
- `review-db`: スキーマ/インデックス/SQL/整合性
- `review-infra`: IAM/ネットワーク/可用性/コスト/IaC
- `review-t-wada`: テスト品質/テスタビリティ/保守性
- `review-kawasima`: ドメインモデリング/設計原則
- `review-pitfall`: 見落としやすい落とし穴（バージョン/機密/TODO）

---

運用メモ:

- このファイルを Git 管理の正本にする
- 実運用でグローバル適用する場合は、`$HOME/AGENTS.md`（または `~/AGENTS.md`）へ同期（コピーまたはシンボリックリンク）する
