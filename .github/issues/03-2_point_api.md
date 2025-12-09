# ポイント加減算ロジックとAPI実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
Userモデルへのポイント加減算メソッド追加と、ポイント情報取得APIを実装する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ポイントの加減算処理とその履歴記録を一貫して行い、ユーザーがポイント情報を確認できるようにする。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] Userにadd_points/subtract_pointsメソッドが追加されている
- [ ] ポイント不足時のエラーハンドリングが実装されている
- [ ] ポイント情報取得APIが実装されている
- [ ] ポイント履歴取得APIが実装されている
- [ ] テストが書かれている

## API仕様
<!-- エンドポイント、メソッド、リクエスト/レスポンス形式 -->

### エンドポイント
```
GET /api/v1/points                   # 自分のポイント情報取得
GET /api/v1/points/history           # ポイント履歴取得
```

### レスポンス（ポイント情報）
```json
{
  "points": {
    "current_pve_point": 500,
    "current_pvp_point": 300
  }
}
```

### レスポンス（ポイント履歴）
```json
{
  "point_transactions": [
    {
      "id": 1,
      "point_type": "pvp",
      "amount": 100,
      "reason": "daily_weight_record",
      "created_at": "2025-01-10T09:00:00.000Z"
    }
  ],
  "meta": {
    "total_count": 25,
    "current_page": 1,
    "per_page": 20
  }
}
```

## ビジネスロジック
```ruby
class User < ApplicationRecord
  class InsufficientPointsError < StandardError; end

  def add_points(amount, point_type:, reason:, room: nil)
    transaction do
      case point_type
      when 'pve'
        increment!(:current_pve_point, amount)
      when 'pvp'
        increment!(:current_pvp_point, amount)
      end

      point_transactions.create!(
        room: room,
        point_type: point_type,
        amount: amount,
        reason: reason
      )
    end
  end

  def subtract_points(amount, point_type:, reason:, room: nil)
    current = point_type == 'pve' ? current_pve_point : current_pvp_point
    raise InsufficientPointsError, "ポイントが不足しています" if current < amount

    add_points(-amount, point_type: point_type, reason: reason, room: room)
  end
end
```

## 依存関係
- Issue #03-1（PointTransactionモデル）が完了していること

## ブランチ
`feature/03-2-point-api`

## テスト計画
- [ ] Userモデルテスト
  - [ ] add_pointsでポイントが増える
  - [ ] subtract_pointsでポイントが減る
  - [ ] ポイント不足時にエラーが発生する
  - [ ] 履歴が正しく記録される
- [ ] APIテスト
  - [ ] ポイント情報取得成功
  - [ ] ポイント履歴取得成功（ページネーション）
