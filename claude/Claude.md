# Claude Code 設定

このファイルは dotfiles で管理し、`~/.claude/CLAUDE.md` にコピーして使用する。
Claude Code がグローバルに参照する設定・コンテキストを定義。

## 使い方

```bash
cp /path/to/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
```

## Tech Stack

### 主要言語
- **TypeScript/JavaScript** - Next.js, React, Vitest, Playwright
- **Terraform** - AWS (VPC, Route53, ECR) インフラ管理
- **Rust** - CLIツール開発 (goodbye, bye)
- **Shell** - zsh, tmux 設定

### ツール類
- Node.js / npm
- AWS CLI
- Git
- mise (バージョン管理)
- Homebrew

## Development Guidelines

### Coding Style

- モジュール単位での設計を重視
- 環境分離を明確に (dev/production)
- 型安全性を重視 (TypeScript)
- 日本語ドキュメントを並行作成 (README.ja.md など)

### 作業プロセス

- 段階的な実装 (STEP1 → STEP2 → ...)
- テスト駆動開発 (E2E/ユニットテスト)
- コードレビュー重視
- 試行錯誤的アプローチ (試してみて → レビュー → 修正)

### Git Workflow

- 意味のあるコミットメッセージ
- PR ベースでのレビュー

### ファイル構成パターン

- `specs/todo/` → `specs/done/` への進捗追跡
- `testing/docs/` `testing/review/` による構造化ドキュメント
- `logs/` による作業記録の履歴管理

## Commands

```bash
# Node.js
npm run build
npm run test
npm run test:e2e

# Terraform
terraform plan
terraform apply
terraform import

# Git
git status
git commit
git push
```

## Important Notes

- 「なぜ？」という理由説明を求められることがある
- 日本語での細かい指示出しが多い
- 段階的に実装を進める（一度に全部ではなく）
- テストを書くことを重視

## Context

このファイルは Claude Code の CLAUDE.md として使用。
プロジェクト固有のコンテキストを追加することで、より適切なアシストを受けられる。
