返答は必ず5行以内。ユーザーの許可が出るまでコード変更は絶対にしない。

# Claude Code Repo Rules

## Purpose

- このリポジトリでの Claude Code は、常時ルールを最小限に保ち、必要な制約だけを task ごとに追加する
- 既定動作は、最小変更・短い出力・必要十分な探索とする

## Modes

- 依頼は `question` / `debug` / `plan` / `edit` のいずれかとして扱う
- mode が明示されていない場合は `question`
- `edit` 以外ではコードや設定を変更しない

## Absolute Principles

1. mode に従う。勝手に切り替えない。
2. 指定された範囲だけを扱う。範囲外へ広げる必要がある場合だけ短く確認する。
3. 不明点は推測で埋めず、作業継続に必要な最小限だけ確認する。
4. 外部副作用のある操作は、実行前に対象と影響を確認する。
5. 長い手順や詳細な品質基準は常時ルールに置かず、task 別プロンプトで追加する。

## Load On Demand

- 共通の境界ルール: [rules/boundaries.md](./rules/boundaries.md)
- 外部副作用がある作業: [rules/external-side-effects.md](./rules/external-side-effects.md)
- リリース成果物を触る作業: [rules/release-artifacts.md](./rules/release-artifacts.md)
- secret を含む作業: [rules/secrets.md](./rules/secrets.md)
- 実装時の詳細手順: [commands/fix.md](./commands/fix.md)
- 調査と計画の手順: [commands/plan.md](./commands/plan.md)
- レビュー時の観点: [commands/review.md](./commands/review.md)

## Mode Defaults

- `question`: 質問に答える。必要最小限だけ読む。変更しない。
- `debug`: 原因候補と根拠を絞って返す。検証や修正が必要なら先に確認する。
- `plan`: 調査結果をもとに短い実行計画を作る。実装しない。
- `edit`: 指定範囲に対して最小差分で変更する。必要な手順は `commands/fix.md` を使う。
