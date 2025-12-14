# JWT削除とDeviseクリーンアップ計画

`devise-jwt` の削除と、Devise関連の設定がクリーンな状態であることを検証し、アプリケーションが正常に起動することを確認します。

## 概要

現状、`Gemfile` および主要なコードからはすでに `devise-jwt` が削除されているようです。
本計画では、残存設定がないかの最終チェックと、アプリケーションの正常起動確認（検証）のみを行います。

## 検証計画（学習ガイド・コマンド解説付き）

### 1. 依存関係の確認: `bundle check`

> [!TIP]
> **なぜこれを行うの？**
> `Gemfile`（設計図）と実際にインストールされているGem（現状）が一致しているかを確認する健康診断です。

```bash
docker compose run --rm api bundle check
```

<details>
<summary><strong>🔍 コマンド解剖（クリックで展開）</strong></summary>

- `docker compose`: 複数のコンテナ（DBやWebアプリなど）をまとめて管理するツール。
- `run`: サービス（コンテナ）を新しく1つ起動して、一度きりのコマンドを実行します。
- `--rm`: **Remove**の略。コマンドが終わったら、使い終わったコンテナをすぐに削除します（ディスク容量の節約）。
- `api`: `compose.yml` で定義されているサービス名。今回はRailsアプリを指します。
- `bundle check`: コンテナの中で実行される実際のコマンド。Gemの不足がないかチェックします。

</details>

---

### 2. Railsアプリケーション起動確認: `rails runner`

> [!TIP]
> **なぜこれを行うの？**
> サーバーを完全に立ち上げることなく、Railsのシステム全体がエラーなく読み込めるかをテストします。

```bash
docker compose run --rm api bundle exec rails runner "puts 'Rails Booted Successfully'"
```

<details>
<summary><strong>🔍 コマンド解剖（クリックで展開）</strong></summary>

- `docker compose run --rm api`: （前回と同じ：apiコンテナを一時的に起動）
- `bundle exec`: Gemfileで指定された**正しいバージョン**のライブラリを使ってコマンドを実行するための「おまじない」です。これがないと、システムに入っている別のバージョンのRailsが動いてしまう事故が起きたりします。
- `rails runner`: Railsの環境を読み込んだ上で、後ろに続く短いRubyコードを実行するコマンド。
- `"puts 'Rails Booted Successfully'"`: 実行するRubyコード。「Rails Booted Successfully」という文字を表示するだけの単純な処理ですが、ここまで辿り着くにはRailsの起動処理が成功していなければなりません。

</details>

---

### 3. Devise設定の確認: `Devise modules`

> [!TIP]
> **なぜこれを行うの？**
> Devise（認証機能）が「JWTを使う」という設定をまだ覚えているかどうかを確認します。完全に忘れて（無効化されて）いればOKです。

```bash
docker compose run --rm api bundle exec rails runner "p Devise.mappings[:user].modules.include?(:jwt_authenticatable)"
```

<details>
<summary><strong>🔍 コマンド解剖（クリックで展開）</strong></summary>

- `... rails runner`: （前回と同じ：Rails環境でRubyコードを実行）
- `"p ..."`: Rubyの `p` メソッドは、データを人間にわかりやすい形式で表示します。
- `Devise.mappings[:user]`: Deviseの設定から「User」モデルに関するものを取り出します。
- `.modules`: そのUserモデルで有効になっている機能（モジュール）のリストを取得します。
- `.include?(:jwt_authenticatable)`: そのリストの中に「JWT認証機能」が含まれているかを判定します。これの結果が `false`（含まれていない）なら成功です。

</details>
