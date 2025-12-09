# Title/UserTitleモデルの実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
称号マスタ（Title）とユーザー称号獲得記録（UserTitle）のモデルを作成する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ゲーミフィケーション要素として、ユーザーの達成度に応じた称号を管理する。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] Titleモデルが作成されている
- [ ] UserTitleモデルが作成されている
- [ ] 装備中の称号を1つだけ設定できる
- [ ] シードデータが投入されている
- [ ] モデルテストが書かれている

## データモデル変更

### テーブル名: titles
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| name | string | not null, unique | |
| description | text | not null | |
| icon | string | | |
| condition_type | string | not null | |
| condition_value | integer | | |
| rarity | integer | not null, default: 0 | common=0, rare=1, epic=2, legendary=3 |
| is_active | boolean | not null, default: true | |

### テーブル名: user_titles
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| user_id | bigint | not null, FK | |
| title_id | bigint | not null, FK | |
| earned_at | datetime | not null | |
| is_equipped | boolean | not null, default: false | |

### Migration
```ruby
class CreateTitles < ActiveRecord::Migration[7.2]
  def change
    create_table :titles do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :icon
      t.string :condition_type, null: false
      t.integer :condition_value
      t.integer :rarity, null: false, default: 0
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end

    add_index :titles, :name, unique: true
  end
end

class CreateUserTitles < ActiveRecord::Migration[7.2]
  def change
    create_table :user_titles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :title, null: false, foreign_key: true
      t.datetime :earned_at, null: false
      t.boolean :is_equipped, null: false, default: false

      t.timestamps
    end

    add_index :user_titles, [:user_id, :title_id], unique: true
  end
end
```

## 依存関係
- Issue #01シリーズが完了していること

## ブランチ
`feature/07-1-title-model`

## テスト計画
- [ ] モデルテスト
  - [ ] Title: name必須・一意性
  - [ ] UserTitle: 同一称号の重複獲得不可
  - [ ] 装備時に他の称号が外れる
