# ルーム機能の実装

## 概要
ダイエット対決を行うルームの作成・参加・退出機能を実装する。

## 目的・背景
- 複数ユーザーが参加してダイエット対決を行う場を提供
- PvP/PvEモード対応のルーム管理
- 公開/非公開ルームの設定

## 完了条件
- [ ] Roomモデルが作成されている（room_type, status enum対応）
- [ ] RoomMembershipモデルが作成されている
- [ ] ルームCRUD APIが実装されている
- [ ] 参加・退出APIが実装されている
- [ ] 最大人数制限が機能する
- [ ] 全てのテストが通過する

## サブイシュー

| イシュー | タイトル | 依存関係 |
|----------|----------|----------|
| [05-1_room_model.md](./05-1_room_model.md) | Roomモデルの実装 | #01シリーズ |
| [05-2_room_membership_model.md](./05-2_room_membership_model.md) | RoomMembershipモデルの実装 | #05-1 |
| [05-3_room_api.md](./05-3_room_api.md) | ルームAPI実装 | #05-2 |

## 技術詳細
- room_type: pvp(0), pve(1)
- status: inviting(0), active(1), finished(2), cancelled(3)
- RoomMembershipで参加・退出を追跡

## 依存関係
- #01_auth（認証機能）が完了していること

## 後続機能への影響
- ちょっかい機能（ルーム内でちょっかいを送信）
- スタンプ機能（ルーム内メッセージ）
- ゲームモード機能（ボス戦・ランキング）
