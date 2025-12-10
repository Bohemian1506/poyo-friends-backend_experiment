# PointTransactionモデルの実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
ポイント取引履歴を管理するPointTransactionモデルを作成する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ゲーミフィケーション要素として、ポイントの獲得・消費履歴を記録し追跡できるようにする。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] PointTransactionモデルが作成されている
- [ ] User/Roomとのアソシエーションが設定されている
- [ ] バリデーションが設定されている
- [ ] モデルテストが書かれている

## データモデル変更

### テーブル名: point_transactions
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| user_id | bigint | not null, FK(users) | |
| room_id | bigint | FK(rooms) | 関連ルーム（任意） |
| point_type | string | not null | "pve" or "pvp" |
| amount | integer | not null | 加算/減算額 |
| reason | string | not null | 理由 |

### Migration
```ruby
class CreatePointTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :point_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, foreign_key: true
      t.string :point_type, null: false
      t.integer :amount, null: false
      t.string :reason, null: false

      t.timestamps
    end

    add_index :point_transactions, :point_type
    add_index :point_transactions, :created_at
  end
end
```

## 依存関係
- Issue #01シリーズが完了していること

## ブランチ
`feature/03-1-point-transaction-model`

## テスト計画
- [ ] モデルテスト
  - [ ] point_type必須バリデーション
  - [ ] amount必須バリデーション
  - [ ] reason必須バリデーション
  - [ ] Userとのアソシエーション
