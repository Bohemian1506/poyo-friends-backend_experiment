# WeightRecordモデルの実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
体重記録を管理するWeightRecordモデルを作成し、前日比の自動計算機能を実装する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ダイエットアプリの中核となる体重記録機能の基盤を構築する。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] WeightRecordモデルが作成されている
- [ ] Userとのアソシエーションが設定されている
- [ ] 前日比計算のコールバックが実装されている
- [ ] バリデーションが設定されている
- [ ] モデルテストが書かれている

## データモデル変更

### テーブル名: weight_records
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| user_id | bigint | not null, FK(users) | |
| weight | float | not null | 記録した体重 |
| diff_from_last_day | float | | 前日比（自動計算） |
| recorded_on | date | not null | 記録日 |

### Migration
```ruby
class CreateWeightRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :weight_records do |t|
      t.references :user, null: false, foreign_key: true
      t.float :weight, null: false
      t.float :diff_from_last_day
      t.date :recorded_on, null: false

      t.timestamps
    end

    add_index :weight_records, [:user_id, :recorded_on], unique: true
    add_index :weight_records, :recorded_on
  end
end
```

### ビジネスロジック
```ruby
class WeightRecord < ApplicationRecord
  belongs_to :user

  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :recorded_on, presence: true
  validates :user_id, uniqueness: { scope: :recorded_on, message: "同日の記録は1回のみ" }

  before_save :calculate_diff_from_last_day

  private

  def calculate_diff_from_last_day
    previous_record = user.weight_records
                         .where('recorded_on < ?', recorded_on)
                         .order(recorded_on: :desc)
                         .first
    
    self.diff_from_last_day = previous_record ? (weight - previous_record.weight).round(2) : nil
  end
end
```

## 依存関係
- Issue #01シリーズが完了していること

## ブランチ
`feature/02-1-weight-record-model`

## テスト計画
- [ ] モデルテスト
  - [ ] weight必須バリデーション
  - [ ] recorded_on必須バリデーション
  - [ ] 同日同ユーザーで重複不可
  - [ ] 前日比計算が正しく動作する
  - [ ] Userとのアソシエーション
