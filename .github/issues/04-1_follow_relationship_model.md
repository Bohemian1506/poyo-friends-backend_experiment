# FollowRelationshipモデルの実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
ユーザー間のフォロー関係を管理するFollowRelationshipモデルを作成する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ソーシャル機能の基盤として、ユーザー同士のフォロー・フォロワー関係を構築する。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] FollowRelationshipモデルが作成されている
- [ ] Userモデルにfollowing/followersアソシエーションが追加されている
- [ ] 自分自身をフォローできない制約がある
- [ ] 重複フォロー防止の制約がある
- [ ] モデルテストが書かれている

## データモデル変更

### テーブル名: follow_relationships
| カラム名 | 型 | 制約 | 説明 |
|---------|-----|------|------|
| id | bigint | primary key | |
| follower_id | bigint | not null, FK(users) | フォローする側 |
| followee_id | bigint | not null, FK(users) | フォローされる側 |

### Migration
```ruby
class CreateFollowRelationships < ActiveRecord::Migration[7.2]
  def change
    create_table :follow_relationships do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :followee, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :follow_relationships, [:follower_id, :followee_id], unique: true
    add_check_constraint :follow_relationships, 'follower_id != followee_id', name: 'check_no_self_follow'
  end
end
```

### Userモデル拡張
```ruby
class User < ApplicationRecord
  has_many :active_follow_relationships,
           class_name: 'FollowRelationship',
           foreign_key: 'follower_id',
           dependent: :destroy
  has_many :following, through: :active_follow_relationships, source: :followee

  has_many :passive_follow_relationships,
           class_name: 'FollowRelationship',
           foreign_key: 'followee_id',
           dependent: :destroy
  has_many :followers, through: :passive_follow_relationships, source: :follower

  def follow(other_user)
    following << other_user unless following.include?(other_user)
  end

  def unfollow(other_user)
    active_follow_relationships.find_by(followee: other_user)&.destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def mutual_follow?(other_user)
    following?(other_user) && other_user.following?(self)
  end
end
```

## 依存関係
- Issue #01シリーズが完了していること

## ブランチ
`feature/04-1-follow-relationship-model`

## テスト計画
- [ ] モデルテスト
  - [ ] フォロー関係が作成できる
  - [ ] 自己フォローが不可
  - [ ] 重複フォローが不可
  - [ ] following/followersアソシエーション
  - [ ] following?/mutual_follow?メソッド
