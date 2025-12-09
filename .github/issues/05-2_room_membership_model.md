# RoomMembershipモデルの実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
ユーザーとルームの参加関係を管理するRoomMembershipモデルを作成する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ユーザーがどのルームに参加しているかを管理し、参加・退出を追跡する。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] RoomMembershipモデルが作成されている
- [ ] Room/Userとのアソシエーションが設定されている
- [ ] 同一ルームへの重複参加防止制約がある
- [ ] バリデーションが設定されている
- [ ] モデルテストが書かれている

## データモデル変更

### テーブル名: room_memberships
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| room_id | bigint | not null, FK(rooms) | |
| user_id | bigint | not null, FK(users) | |
| joined_at | datetime | not null | |
| left_at | datetime | | |

### Migration
```ruby
class CreateRoomMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :room_memberships do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :joined_at, null: false
      t.datetime :left_at

      t.timestamps
    end

    add_index :room_memberships, [:room_id, :user_id], unique: true
  end
end
```

## 依存関係
- Issue #05-1（Roomモデル）が完了していること

## ブランチ
`feature/05-2-room-membership-model`

## テスト計画
- [ ] モデルテスト
  - [ ] Room/Userアソシエーション
  - [ ] 同一ルームへの重複参加不可
  - [ ] joined_at必須バリデーション
