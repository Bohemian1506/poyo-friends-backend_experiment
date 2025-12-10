# ChokkaiInstanceモデルの実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
送信されたちょっかいインスタンスを管理するChokkaiInstanceモデルを作成する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
実際に送信されたちょっかいとその状態（pending/cleared/expired）を追跡する。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] ChokkaiInstanceモデルが作成されている
- [ ] ステータス管理ができる
- [ ] 有効期限が設定される
- [ ] モデルテストが書かれている

## データモデル変更

### テーブル名: chokkai_instances
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| chokkai_template_id | bigint | not null, FK | |
| from_user_id | bigint | not null, FK(users) | 送信者 |
| to_user_id | bigint | FK(users) | 受信者 |
| room_id | bigint | not null, FK | |
| status | integer | not null, default: 0 | pending=0, cleared=1, expired=2 |
| cleared_at | datetime | | |
| expires_at | datetime | not null | |

### Migration
```ruby
class CreateChokkaiInstances < ActiveRecord::Migration[7.2]
  def change
    create_table :chokkai_instances do |t|
      t.references :chokkai_template, null: false, foreign_key: true
      t.references :from_user, null: false, foreign_key: { to_table: :users }
      t.references :to_user, foreign_key: { to_table: :users }
      t.references :room, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.datetime :cleared_at
      t.datetime :expires_at, null: false

      t.timestamps
    end

    add_index :chokkai_instances, :status
    add_index :chokkai_instances, :expires_at
  end
end
```

## ビジネスロジック
```ruby
class ChokkaiInstance < ApplicationRecord
  enum status: { pending: 0, cleared: 1, expired: 2 }

  before_create :set_expires_at

  def set_expires_at
    self.expires_at = 24.hours.from_now
  end

  def clear!
    update!(status: :cleared, cleared_at: Time.current)
  end
end
```

## 依存関係
- Issue #06-1（ChokkaiTemplateモデル）が完了していること
- Issue #05シリーズ（Roomモデル）が完了していること

## ブランチ
`feature/06-2-chokkai-instance-model`

## テスト計画
- [ ] モデルテスト
  - [ ] 有効期限自動設定
  - [ ] ステータス遷移
  - [ ] アソシエーション
