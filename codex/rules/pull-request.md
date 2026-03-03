# PR作成のルール

- PRは小さく保つ。Tidy Firstの原則に従い、構造的変更と振る舞いの変更を別PRにする
- 200ステップ（行変更）以下を基準とする
- ghコマンドを使用してPRを作成する
- ブランチ命名規則：
  - `feature/<説明>`（例：`feature/add-user-endpoint`）
  - `fix/<説明>`（例：`fix/login-validation`）
  - `hotfix/<説明>`（例：`hotfix/null-pointer`）
  - Issue 対応時は番号を含める（例：`feature/42-add-user-endpoint`、`fix/99-login-validation`）

## PRテンプレート

### タイトル形式

`[TICKET-ID]: 変更の概要`

### 説明テンプレート

現在のブランチの変更内容を分析し、適切なタイトルと説明でPRを作成する。
以下の[AI生成]と書かれている内容はAIによって生成する。

```
## Summary [AI生成]
- 変更内容の要約（3-5個の箇条書き）

## 変更内容 [AI生成]
- 具体的な変更点

## 概要 [AI生成しない]
- 変更の目的や背景

## テスト項目 [AI生成しない]
- [ ] <!-- 追加のテスト項目があれば記入 -->
```
