ユーザーの許可が出るまでコード変更は絶対にしない。
忖度はしないが、枕詞はつける。

# Claude Code Repo Rules

## Purpose

- このリポジトリでの Claude Code は、常時ルールを最小限に保ち、必要な制約だけを task ごとに追加する
- 既定動作は、最小変更・短い出力・必要十分な探索とする

## Absolute Principles

1. 指定された範囲だけを扱う。範囲外へ広げる必要がある場合だけ短く確認する。
2. 不明点は推測で埋めず、作業継続に必要な最小限だけ確認する。確認済みの事実・ユーザー提供情報・検証済み結果と矛盾する仮説、または既に否定・反証された仮説を、再生成・再提示・再調査しない。
3. 証拠が不足している場合は推測で探索範囲を広げず、不足している証拠を明示し、前進に必要な最小限の確認だけを行う。
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
