# Userモデル基盤の構築

## 概要
<!-- 何を実装するのか簡潔に記載 -->
Deviseを使用したUserモデルの拡張。新しいスキーマに合わせてカラムを追加する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ダイエットアプリの基盤となるUserモデルを完成させる。体重やポイント、ルーム参加状態などのカラムを追加し、後続のISSUEで使用できるようにする。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] Userモデルに必要なカラムがすべて追加されている
- [ ] マイグレーションが正常に実行される
- [ ] バリデーションが適切に設定されている
- [ ] モデルのテストが書かれている

## データモデル変更

### テーブル名: users（追加カラム）
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| pve_room_id | bigint | FK(rooms) | 現在参加中のPvEルーム |
| pvp_room_id | bigint | FK(rooms) | 現在参加中のPvPルーム |
| blacklisted_tricks | text | | ブラックリストトリックID（JSON配列） |
| weekly_trick_received_count | integer | default: 0 | 週間トリック受信数 |
| current_pve_point | integer | default: 0 | PvEポイント |
| current_pvp_point | integer | default: 0 | PvPポイント |

### Migration
```ruby
class AddGameColumnsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :pve_room_id, :bigint
    add_column :users, :pvp_room_id, :bigint
    add_column :users, :blacklisted_tricks, :text
    add_column :users, :weekly_trick_received_count, :integer, default: 0
    add_column :users, :current_pve_point, :integer, default: 0
    add_column :users, :current_pvp_point, :integer, default: 0

    add_index :users, :pve_room_id
    add_index :users, :pvp_room_id
  end
end
```

## 依存関係
- Issue #01-1（セッション認証基盤）が完了していること

## ブランチ
`feature/01-2-user-model`

## テスト計画
- [ ] Userモデルのバリデーションテスト
  - [ ] emailの必須チェック
  - [ ] emailの一意性チェック
  - [ ] nameの必須チェック
  - [ ] current_weight/target_weightの数値チェック
- [ ] マイグレーションテスト

## 補足・参考資料
- 外部キー制約はRoomテーブル作成後に追加
