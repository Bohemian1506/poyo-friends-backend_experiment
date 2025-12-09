# Stamp/RoomMessageモデルの実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
スタンプマスタ（Stamp）とルーム内メッセージ（RoomMessage）のモデルを作成する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ルーム内でスタンプを使ったコミュニケーション機能の基盤を構築する。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] Stampモデルが作成されている
- [ ] RoomMessageモデルが作成されている
- [ ] シードデータが投入されている
- [ ] モデルテストが書かれている

## データモデル変更

### テーブル名: stamps
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| name | string | not null | |
| image_url | string | not null | |
| category | string | | reaction, support, greeting, emotion |
| is_active | boolean | not null, default: true | |
| sort_order | integer | default: 0 | |

### テーブル名: room_messages
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| room_id | bigint | not null, FK | |
| user_id | bigint | not null, FK | |
| stamp_id | bigint | not null, FK | |

### Migration
```ruby
class CreateStamps < ActiveRecord::Migration[7.2]
  def change
    create_table :stamps do |t|
      t.string :name, null: false
      t.string :image_url, null: false
      t.string :category
      t.boolean :is_active, null: false, default: true
      t.integer :sort_order, default: 0

      t.timestamps
    end
  end
end

class CreateRoomMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :room_messages do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :stamp, null: false, foreign_key: true

      t.timestamps
    end

    add_index :room_messages, [:room_id, :created_at]
  end
end
```

## 依存関係
- Issue #05シリーズ（Roomモデル）が完了していること

## ブランチ
`feature/08-1-stamp-model`

## テスト計画
- [ ] モデルテスト
  - [ ] Stamp: name/image_url必須
  - [ ] RoomMessage: アソシエーション
