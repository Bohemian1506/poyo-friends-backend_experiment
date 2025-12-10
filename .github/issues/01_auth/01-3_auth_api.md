# 認証API実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
セッションベースの認証API（新規登録・ログイン・ログアウト）を実装する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ユーザーがアプリケーションにアクセスするための認証機能を提供する。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] 新規登録APIが機能する
- [ ] ログインAPIが機能する
- [ ] ログアウトAPIが機能する
- [ ] 認証済み/未認証の状態管理ができる
- [ ] APIテストが書かれている

## API仕様
<!-- エンドポイント、メソッド、リクエスト/レスポンス形式 -->

### エンドポイント
```
POST /api/v1/auth/signup        # 新規登録
POST /api/v1/auth/login         # ログイン
DELETE /api/v1/auth/logout      # ログアウト
```

### リクエスト（新規登録）
```json
{
  "user": {
    "email": "user@example.com",
    "password": "password123",
    "password_confirmation": "password123",
    "name": "田中太郎",
    "current_weight": 75.0
  }
}
```

### リクエスト（ログイン）
```json
{
  "user": {
    "email": "user@example.com",
    "password": "password123"
  }
}
```

### レスポンス（成功）
```json
{
  "user": {
    "id": 1,
    "email": "user@example.com",
    "name": "田中太郎",
    "current_weight": 75.0,
    "current_pve_point": 0,
    "current_pvp_point": 0,
    "created_at": "2025-01-01T00:00:00.000Z"
  },
  "message": "Logged in successfully."
}
```

### レスポンス（エラー）
```json
{
  "error": "Invalid email or password."
}
```

## 認可・認証要件
- セッションベースの認証を使用
- パスワードは最低8文字以上
- メールアドレスの形式バリデーション

## 依存関係
- Issue #01-1, #01-2が完了していること

## ブランチ
`feature/01-3-auth-api`

## テスト計画
- [ ] 認証APIのテスト
  - [ ] 新規登録が成功する
  - [ ] 重複メールで登録失敗する
  - [ ] ログインが成功する
  - [ ] 不正な認証情報でログイン失敗する
  - [ ] ログアウトが成功する
