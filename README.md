# team-app-backend（仮）

チーム開発用のRails APIバックエンドです。

## 概要

このプロジェクトは、Rails API + Next.jsテンプレートをベースに構築されたチーム開発用プロジェクトです。

### 技術スタック

- **Ruby**: 3.3.6
- **Rails**: 7.2系
- **DB**: PostgreSQL 16
- **Docker**: Compose v2形式（compose.yml）
- **ポート**: 3001

## セットアップ手順（初回のみ）

### 1. リポジトリをクローン

```bash
git clone <このリポジトリのURL>
cd team-app-backend
```

### 2. Docker環境で起動

```bash
docker compose up
```

初回起動時に自動的に以下が実行されます：
- Dockerイメージのビルド
- gem のインストール
- PostgreSQLコンテナ起動
- データベース作成
- Railsサーバー起動

### 3. 動作確認

ブラウザで http://localhost:3001 にアクセス

**疎通確認エンドポイント:**
- `GET /api/v1/health` - API疎通確認用（サンプル実装）
- レスポンス: `{"status":"ok","message":"APIが正常に動作しています"}`

### 4. プロジェクト名の変更（アプリ名決定後）

アプリ名が決まったら、以下の手順でリポジトリ名を変更してください。

#### 4-1. GitHubリポジトリ名の変更

1. GitHubのリポジトリページを開く
2. Settings → General → Repository name を変更
3. "Rename" をクリック

#### 4-2. ローカルのremote URLを更新

```bash
# 新しいリポジトリ名に変更（例: my-app-backend）
git remote set-url origin https://github.com/<ユーザー名>/<新しいリポジトリ名>.git

# 確認
git remote -v
```

#### 4-3. 影響範囲の確認

バックエンドでは基本的にリポジトリ名の変更のみで完了です。
以下のファイルにプロジェクト名を含む記述がある場合は適宜修正してください：

- `README.md` - このファイル（プロジェクト名を更新）
- その他、プロジェクト固有の設定ファイル

## 日常的な開発

### コンテナの起動

```bash
docker compose up
```

バックグラウンド起動：
```bash
docker compose up -d
```

### コンテナの停止

```bash
docker compose down
```

### Railsコマンドの実行

```bash
# マイグレーション実行
docker compose exec api bundle exec rails db:migrate

# コンソール起動
docker compose exec api bundle exec rails console

# テスト実行（テストフレームワーク追加後）
docker compose exec api bundle exec rails test
```

### gemの追加

1. `Gemfile` に追加
2. コンテナ再ビルド：
```bash
docker compose up --build
```

## 環境変数

開発環境の環境変数は `compose.yml` に記載済みです。
環境変数ファイルのコピーは不要です。

**本番環境では `.env` ファイルで管理してください。**

### 環境変数一覧（compose.yml参照）

- `DATABASE_HOST`: データベースホスト（デフォルト: db）
- `DATABASE_USER`: データベースユーザー（デフォルト: postgres）
- `DATABASE_PASSWORD`: データベースパスワード（デフォルト: password）
- `DATABASE_NAME`: データベース名（デフォルト: app_development）
- `CORS_ORIGINS`: CORS許可オリジン（デフォルト: http://localhost:3000）

## フロントエンドとの連携

- CORS設定済み（`rack-cors` gem）
- `config/initializers/cors.rb` で許可オリジンを設定可能
- デフォルトでは http://localhost:3000 を許可

## 注意事項

- **疎通確認エンドポイント (`/api/v1/health`) はサンプル実装です**
  - プロジェクトに合わせて作り直すか、削除してください
  - フロントエンドと連携している場合は、フロントエンド側も合わせて修正が必要です
- Mac/Windows両対応（Docker Desktop必須）
- 開発環境専用の設定です
- 本番環境では適切なセキュリティ設定を行ってください

## 含まれているgem

**必須gem:**
- `rails` - Railsフレームワーク
- `pg` - PostgreSQLアダプター
- `puma` - Webサーバー
- `rack-cors` - CORS対応（フロントエンド連携用）
- `bootsnap` - 起動高速化

**開発・テスト用gem（rails new で自動追加、不要なら削除可能）:**
- `tzinfo-data` - タイムゾーン情報（Windows用、Docker環境では不要）
- `debug` - デバッグツール
- `brakeman` - セキュリティ脆弱性チェック
- `rubocop-rails-omakase` - コードスタイルチェック
