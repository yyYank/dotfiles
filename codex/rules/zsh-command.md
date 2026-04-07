# zsh Command

- zsh を必ず考慮してコマンドを提示する。
- `[` `]` `*` `?` を含む引数は、必要に応じて必ずクォートする。
- 良い例: `terraform plan -target='module.ecs.aws_ecs_service.main["live-api"]'`
- 悪い例: `terraform plan -target=module.ecs.aws_ecs_service.main["live-api"]`
