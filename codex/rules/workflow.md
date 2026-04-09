# Workflow Rules

## 絶対に守ること（これだけは必ず）

- `main`, `master`, その他デフォルトブランチへの force-push は禁止。ユーザーが `force push` または `--force-with-lease` と明示的に発言した場合のみ許可
- `terraform plan` / `terraform apply` はユーザーがそのターンで明示的に指示した場合のみ実行する。「次はplanですね」と推測して実行した時点で運用違反
- ミスを指摘されたとき、必要なら原因種別を明示する。`理解不足` / `検証不足` / `設計ミス` / `運用違反` は例であり、名指しを強制しない


## Non-negotiable Rules / 絶対ルール

- Do not add dependencies unless explicitly requested.
  依存追加は禁止（明示指示がある場合のみ可）
- Do not make speculative fixes.
  推測で修正しない
- Do not perform unrelated refactors.
  無関係なリファクタ禁止
- In `debug`, if cause is uncertain, list 2-3 hypotheses and test the most likely.
  `debug` で不確実な場合は仮説を2-3個出し、最も有力なものから検証
- If verification fails, report failure and cause. Do not claim success.
  検証失敗時は成功扱い禁止、原因を報告

## コミット・プッシュ前の確認手順

コミットまたはプッシュを実行する前に、毎回以下を確認する：

1. 現在のブランチ名が意図したブランチか（`git branch --show-current` で確認）
2. プッシュ先のリモートブランチが意図した宛先か（`git remote -v` と合わせて確認）
3. 対象PRが存在する場合、そのPRのベースブランチが正しいか

1つでも不一致があればコミット・プッシュを中止し、ユーザーに報告する。

## merge / rebase / cherry-pick の前に

1. `git fetch origin` を実行してリモートの最新状態を取得する
2. 最新のリモートブランチから作業を開始する
3. fetchせずにmerge/rebase/cherry-pickを始めるのは禁止

## protectedブランチでの履歴操作

- protectedブランチ上で `amend` / `rebase` / `squash` が必要になった場合：新しいコミットを作成するか、別ブランチで作業することを提案する
- 履歴書き換えが本当に必要な場合：「これはprotectedブランチへのforce pushが必要です。実行してよいですか？」と明示的に確認する。確認なしで実行したら運用違反

## CI/CD失敗時の対応手順

1. 失敗ログを全て読む
2. 原因候補を複数洗い出し、優先度の高いものから検証する
3. 原因が複数あると判断した場合は、修正をまとめて提示する
4. 「直したので再実行してください」を繰り返さず、ユーザーの検証往復を最小化する

## 必要な場合の報告フォーマット

```
失敗の種類：[理解不足 / 検証不足 / 設計ミス / 運用違反]
何が起きたか：<事実を1-2文で>
原因：<なぜ起きたか>
防止策：<次回から何をするか>
```

- 必要なときだけ使う。毎回このテンプレートを強制しない
- 曖昧な表現で責任をぼかさない
- ユーザーがダメージや副作用を指摘した場合、「自分が原因である可能性がある」と認めてから調査する。最初に否定しない

## code-change / debug 時の検証レベルの明示

コア実行パス・外部プロセス・デプロイ・git履歴に影響する変更の完了報告時、以下のどれを実施したか明示する：

- [ ] unit test
- [ ] lint
- [ ] format
- [ ] integration test
- [ ] real execution check（実際に動かして確認）

「テスト通りました」だけで完了報告しない。どのレベルまで確認したかを列挙する。


## code-change / debug 時の Definition of Done / 完了条件
Do not say the task is complete unless all are true:
以下をすべて満たすまで完了としない：

1. Root cause is identified with code-level evidence.
   コードレベルの根拠で原因が特定されている
2. Only minimal necessary files were changed.
   必要最小限の変更のみ
3. Required verification commands were executed.
   検証コマンドが実行されている
4. Failing tests are fixed or explicitly reported.
   テスト失敗は修正済み、または明示されている
5. Remaining risks are listed.
   未解決リスクが列挙されている

## code-change / debug 時の Final Response Format / 最終出力フォーマット
Always end with exactly these sections:
必ず以下の形式で出力する：

### Issue / 課題
### Fix / 修正内容
### Changed Files / 変更ファイル
### Verification / 検証
### Remaining Risks / 未解決リスク

Do not omit any section. If unknown, write "Unknown".
省略禁止。不明な場合は「Unknown」と書く。

`question` モードの通常応答には適用しない。

## 同じ箇所の修正が2回失敗したら

3回目の修正コードを書く前に、再現テストまたはintegration testを追加する。テストなしで推測修正を繰り返すのは禁止。

## 具体例

- 良い例： GitHub Actionsで部分的な変更とCI失敗を繰り返すのは、非効率でユーザー負荷が高いため、仮説を複数立て、調査をし、確信の高いものを提案した。また、他の候補も選ばなかった理由も提示した。
- 悪い例： GitHub Actionsでエラーが出た。考えられる候補の中で、可能性が高そうなものを調査や仮説立て、プラン提案などをせずに修正を実行。コミットとpushをしてGitHub Actionsのジョブで結果検証した。結果的に根本原因とは違うタイムアウト時間を伸ばすなど、無意味な変更を繰り替えし時間を無駄にした。
