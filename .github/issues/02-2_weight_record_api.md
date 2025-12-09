# 体重記録API実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
体重記録のCRUD操作と統計情報取得のAPIを実装する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ユーザーが体重を記録・確認できるようにする。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] 体重記録のCRUD APIが実装されている
- [ ] 統計情報APIが実装されている
- [ ] 認証必須のAPIになっている
- [ ] 自分の記録のみ操作可能
- [ ] APIテストが書かれている

## API仕様
<!-- エンドポイント、メソッド、リクエスト/レスポンス形式 -->

### エンドポイント
```
POST /api/v1/weight_records          # 体重記録を作成
GET /api/v1/weight_records           # 体重記録一覧取得
GET /api/v1/weight_records/:id       # 特定の体重記録取得
PUT /api/v1/weight_records/:id       # 体重記録を更新
DELETE /api/v1/weight_records/:id    # 体重記録を削除
GET /api/v1/weight_records/stats     # 統計情報取得
```

### リクエスト（体重記録作成）
```json
{
  "weight_record": {
    "weight": 74.5,
    "recorded_on": "2025-01-10"
  }
}
```

### レスポンス（体重記録作成）
```json
{
  "weight_record": {
    "id": 1,
    "user_id": 1,
    "weight": 74.5,
    "diff_from_last_day": -0.5,
    "recorded_on": "2025-01-10",
    "created_at": "2025-01-10T09:00:00.000Z"
  }
}
```

### レスポンス（統計情報）
```json
{
  "stats": {
    "total_records": 30,
    "latest_weight": 74.5,
    "start_weight": 80.0,
    "total_change": -5.5,
    "average_weight": 77.2
  }
}
```

## 認可・認証要件
- 認証済みユーザーのみアクセス可能
- 自分の記録のみ取得・操作可能

## 依存関係
- Issue #02-1（WeightRecordモデル）が完了していること

## ブランチ
`feature/02-2-weight-record-api`

## テスト計画
- [ ] APIテスト
  - [ ] 体重記録作成成功
  - [ ] 同日重複で作成失敗
  - [ ] 一覧取得成功
  - [ ] 更新成功
  - [ ] 削除成功
  - [ ] 他ユーザーの記録にアクセス不可
