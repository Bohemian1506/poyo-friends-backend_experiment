# ゲームモードAPI（ランキング・ボス状況）の実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
PvPランキングとPvEボス状況取得のAPIを実装する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ルーム内の競争状況やボス戦の進捗を確認できるようにする。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] ランキングAPIが実装されている
- [ ] ボス状況APIが実装されている
- [ ] APIテストが書かれている

## API仕様
<!-- エンドポイント、メソッド、リクエスト/レスポンス形式 -->

### エンドポイント
```
GET /api/v1/rooms/:id/rankings         # ランキング（PvP用）
GET /api/v1/rooms/:id/boss_status      # ボス状況（PvE用）
```

### レスポンス（ランキング）
```json
{
  "rankings": [
    {
      "rank": 1,
      "user_id": 1,
      "name": "田中太郎",
      "weight_loss": 2.5
    },
    {
      "rank": 2,
      "user_id": 2,
      "name": "山田花子",
      "weight_loss": 1.8
    }
  ]
}
```

### レスポンス（ボス状況）
```json
{
  "boss": {
    "name": "お餅モンスター",
    "max_hp": 1000,
    "current_hp": 650,
    "hp_percentage": 65.0,
    "is_defeated": false
  },
  "contributors": [
    {
      "user_id": 1,
      "name": "田中太郎",
      "total_damage": 200
    }
  ]
}
```

## 認可・認証要件
- ルームメンバーのみアクセス可能

## 依存関係
- Issue #09-1（RoomBossモデル）が完了していること

## ブランチ
`feature/09-2-game-mode-api`

## テスト計画
- [ ] APIテスト
  - [ ] PvPルームでランキング取得
  - [ ] PvEルームでボス状況取得
  - [ ] 非メンバーのアクセス失敗
