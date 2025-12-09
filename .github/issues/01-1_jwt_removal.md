# JWT削除とDevise設定のクリーンアップ

## 概要
<!-- 何を実装するのか簡潔に記載 -->
既存のdevise-jwtを削除し、Deviseをクリーンな状態に戻す。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
- 学習目的として、認証部分をシンプル化する
- 現在Gemfileにdevise-jwtが含まれているため、これを削除してクリーンな状態から始める
- セッションベース認証への移行準備

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] devise-jwtがGemfileから削除されている
- [ ] JWT関連の設定ファイルが削除されている（あれば）
- [ ] bundle installが成功する
- [ ] Rails serverが正常に起動する

## 実装タスク

### 1. Gemfile修正
```ruby
# 削除する行
gem "devise-jwt"  # JWT認証用
```

```bash
bundle install
```

### 2. Devise設定確認
- `config/initializers/devise.rb`からJWT関連設定を削除（あれば）
- JWT関連のコントローラーコードがあれば確認

## 依存関係
なし（最初のISSUE）

## ブランチ
`feature/01-1-jwt-removal`

## テスト計画
- [ ] `bundle install`が成功する
- [ ] `rails server`が起動する
- [ ] 既存のルーティングでエラーが発生しない

## 補足・参考資料
- CORS設定やセッション設定は後続ISSUEで対応予定
