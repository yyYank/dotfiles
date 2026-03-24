# シークレット・トークンを勝手に変更しない

env のトークン、シークレット、APIキー、認証情報を含むいかなる記述も、明示的な許可なく変更・削除・追加しない。

対象例：
- CLERK_SECRET_KEY、NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY
- DATABASE_URL
- .env.local、.env、workflow の env ブロック内の認証情報
- secrets.APP_ID、secrets.APP_PRIVATE_KEY 等

必ずユーザーに内容を提示して「やってください」と明示的に言われてから実行する。
