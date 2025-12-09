# ルームAPI実装

## 概要
<!-- 何を実装するのか簡潔に記載 -->
ルームの作成・参加・退出・一覧取得のAPIを実装する。

## 目的・背景
<!-- なぜこの機能が必要か、どんな課題を解決するか -->
ユーザーがルームを作成し、他のユーザーと一緒にダイエット対決ができるようにする。

## 受け入れ基準
<!-- この機能が完成したと判断できる条件 -->
- [ ] ルームCRUD APIが実装されている
- [ ] 参加・退出APIが実装されている
- [ ] メンバー一覧APIが実装されている
- [ ] 最大人数制限が機能する
- [ ] APIテストが書かれている

## API仕様
<!-- エンドポイント、メソッド、リクエスト/レスポンス形式 -->

### エンドポイント
```
POST /api/v1/rooms                    # ルーム作成
GET /api/v1/rooms                     # ルーム一覧取得（公開ルーム）
GET /api/v1/rooms/:id                 # ルーム詳細取得
PUT /api/v1/rooms/:id                 # ルーム更新（マスターのみ）
DELETE /api/v1/rooms/:id              # ルーム削除（マスターのみ）
POST /api/v1/rooms/:id/join           # ルームに参加
DELETE /api/v1/rooms/:id/leave        # ルームから退出
GET /api/v1/rooms/:id/members         # ルームメンバー一覧
GET /api/v1/users/me/rooms            # 自分が参加しているルーム一覧
```

### リクエスト（ルーム作成）
```json
{
  "room": {
    "name": "1月のダイエット対決",
    "room_type": "pvp",
    "is_public": true,
    "max_members": 4,
    "invitation_period_days": 3,
    "duration_days": 30
  }
}
```

### レスポンス（ルーム詳細）
```json
{
  "room": {
    "id": 1,
    "name": "1月のダイエット対決",
    "room_type": "pvp",
    "is_public": true,
    "max_members": 4,
    "current_members_count": 2,
    "room_master_id": 1,
    "status": "inviting"
  }
}
```

## 認可・認証要件
- ルーム作成は認証必須
- ルーム更新・削除はルームマスターのみ
- 公開ルームは誰でも閲覧可能
- 最大人数に達したルームには参加不可

## 依存関係
- Issue #05-2（RoomMembershipモデル）が完了していること

## ブランチ
`feature/05-3-room-api`

## テスト計画
- [ ] APIテスト
  - [ ] ルーム作成成功
  - [ ] 公開ルーム一覧取得
  - [ ] ルーム詳細取得
  - [ ] 参加成功
  - [ ] 満員ルームへの参加失敗
  - [ ] 退出成功
  - [ ] マスター以外の更新・削除失敗
