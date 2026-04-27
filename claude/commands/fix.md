# /fix

- 目的は、指定範囲に対する最小差分の修正に限定する
- 実装前に毎回長い確認儀式は入れず、不足情報がある場合だけ確認する
- テストの追加・修正で振る舞いを変える依頼では [../rules/tdd.md](../rules/tdd.md) を適用する
- 整形・命名変更・責務分離などの構造変更を先に入れるときは [../rules/tidy-first.md](../rules/tidy-first.md) を適用する
- 振る舞い変更と構造変更が両方ある場合は、先に `tidy-first`、次に `tdd` の順で進める
- テスト・lint・build は「変更に直接関係する最小範囲」を優先する
- 全体テストや広い再確認は、依頼がある場合か影響範囲が広い場合だけ行う
- PR・commit・push の前提が必要な作業だけ [../rules/workflow.md](../rules/workflow.md) と [../rules/commit.md](../rules/commit.md) を参照する
- 夜間自律開発セッションのときだけ `night-work` skill を使う

必要に応じて参照:

- [../rules/boundaries.md](../rules/boundaries.md)
- [../rules/external-side-effects.md](../rules/external-side-effects.md)
- [../rules/release-artifacts.md](../rules/release-artifacts.md)
