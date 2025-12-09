# ゲームモード基盤（PvEボス戦）の実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
PvEモード用のボス戦基盤を実装する。RoomBossモデルとボスへのダメージ処理。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
PvEルームでボスを倒す協力戦モードを提供する。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] RoomBossモデルが作成されている
- [ ] ボスダメージ処理ができる
- [ ] ボス討伐判定ができる
- [ ] モデルテストが書かれている

## データモデル変更

### テーブル名: room_bosses
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| room_id | bigint | not null, FK, unique | |
| name | string | not null | |
| max_hp | integer | not null | |
| current_hp | integer | not null | |
| is_defeated | boolean | not null, default: false | |
| defeated_at | datetime | | |

### Migration
```ruby
class CreateRoomBosses < ActiveRecord::Migration[7.2]
  def change
    create_table :room_bosses do |t|
      t.references :room, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :max_hp, null: false
      t.integer :current_hp, null: false
      t.boolean :is_defeated, default: false, null: false
      t.datetime :defeated_at

      t.timestamps
    end

    add_index :room_bosses, :room_id, unique: true
  end
end
```

## ビジネスロジック
```ruby
class RoomBoss < ApplicationRecord
  belongs_to :room

  def take_damage(amount)
    new_hp = [current_hp - amount, 0].max
    update!(current_hp: new_hp)
    check_defeated!
  end

  def check_defeated!
    return if is_defeated
    return if current_hp > 0

    update!(is_defeated: true, defeated_at: Time.current)
  end

  def hp_percentage
    (current_hp.to_f / max_hp * 100).round(1)
  end
end
```

## 依存関係
- Issue #05シリーズ（Roomモデル）が完了していること

## ブランチ
`feature/09-1-room-boss-model`

## テスト計画
- [ ] モデルテスト
  - [ ] ダメージ処理
  - [ ] 討伐判定
  - [ ] HP計算
