# ChokkaiTemplateモデルの実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
運営が提供するちょっかいテンプレートを管理するChokkaiTemplateモデルを作成する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ユーザー間で送信できる「ちょっかい」の種類を定義し、管理する。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] ChokkaiTemplateモデルが作成されている
- [ ] レベル（難易度）とポイントコストが設定できる
- [ ] シードデータが投入されている
- [ ] モデルテストが書かれている

## データモデル変更

### テーブル名: chokkai_templates
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| name | string | not null | |
| description | text | not null | |
| level | integer | not null | 1: easy, 2: medium, 3: hard |
| point_cost | integer | not null | |
| icon | string | | |
| is_active | boolean | not null, default: true | |

### Migration
```ruby
class CreateChokkaiTemplates < ActiveRecord::Migration[7.2]
  def change
    create_table :chokkai_templates do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :level, null: false
      t.integer :point_cost, null: false
      t.string :icon
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end

    add_index :chokkai_templates, :level
    add_index :chokkai_templates, :is_active
  end
end
```

### シードデータ
```ruby
ChokkaiTemplate.create!([
  { name: '10回スクワット', description: 'スクワットを10回やってください', level: 1, point_cost: 50, icon: 'squat' },
  { name: '30秒プランク', description: 'プランクを30秒キープしてください', level: 2, point_cost: 100, icon: 'plank' },
  { name: '腕立て20回', description: '腕立て伏せを20回やってください', level: 3, point_cost: 150, icon: 'pushup' }
])
```

## 依存関係
- Issue #01シリーズが完了していること

## ブランチ
`feature/06-1-chokkai-template-model`

## テスト計画
- [ ] モデルテスト
  - [ ] name必須バリデーション
  - [ ] level必須バリデーション
  - [ ] point_cost必須バリデーション
  - [ ] スコープ（active, レベル別）
