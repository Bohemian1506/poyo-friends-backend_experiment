# Roomモデルの実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
ダイエット対決を行うルームを管理するRoomモデルを作成する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
複数ユーザーが参加してダイエット対決を行う場を提供する。PvP/PvEモード対応。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] Roomモデルが作成されている
- [ ] room_typeのenum（pvp/pve）が設定されている
- [ ] statusのenum（inviting/active/finished/cancelled）が設定されている
- [ ] バリデーションが設定されている
- [ ] モデルテストが書かれている

## データモデル変更

### テーブル名: rooms
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| name | string | not null | |
| room_type | integer | not null, default: 0 | enum: pvp=0, pve=1 |
| is_public | boolean | not null, default: true | |
| max_members | integer | not null | |
| room_master_id | bigint | not null, FK(users) | |
| goal_weight | float | | 目標減量kg（任意） |
| daily_chokkai_limit | integer | not null, default: 3 | |
| invitation_period_days | integer | not null | |
| duration_days | integer | not null | |
| start_date | datetime | | |
| end_date | datetime | | |
| status | integer | not null, default: 0 | |

### Migration
```ruby
class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.integer :room_type, null: false, default: 0
      t.boolean :is_public, null: false, default: true
      t.integer :max_members, null: false
      t.references :room_master, null: false, foreign_key: { to_table: :users }
      t.float :goal_weight
      t.integer :daily_chokkai_limit, null: false, default: 3
      t.integer :invitation_period_days, null: false
      t.integer :duration_days, null: false
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :rooms, :status
    add_index :rooms, [:is_public, :status]
  end
end
```

## 依存関係
- Issue #01シリーズが完了していること

## ブランチ
`feature/05-1-room-model`

## テスト計画
- [ ] モデルテスト
  - [ ] name必須バリデーション
  - [ ] max_members正の整数バリデーション
  - [ ] room_type enumの動作
  - [ ] status enumの動作
