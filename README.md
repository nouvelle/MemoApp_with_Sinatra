# Sinatra を使った Memoアプリ

## 概要
このリポジトリは、Sinatra を使った Memoアプリです。
<div>
  <img src="https://user-images.githubusercontent.com/5979966/183446313-b98e4048-2125-4680-a6ae-22384dbfd7a4.png" alt="top" width="24%">
  <img src="https://user-images.githubusercontent.com/5979966/183446331-fd217f4a-77a1-4d31-997b-b6a8cffc88eb.png" alt="add" width="24%">
  <img src="https://user-images.githubusercontent.com/5979966/183446345-84c5310d-2eab-4097-b54c-15e8c48facba.png" alt="show" width="24%">
  <img src="https://user-images.githubusercontent.com/5979966/183446355-7b94123f-f849-4f5c-a26f-8961e761d192.png" alt="edit" width="24%">
</div>

## セットアップ手順
以下の手順に従ってセットアップを行ってください。

```
# 1. このリポジトリを clone する
$ git clone https://github.com/nouvelle/MemoApp_with_Sinatra.git

# 2. clone したリポジトリに移動する
$ cd MemoApp_with_Sinatra

# 3. パッケージをインストールする
$ bundle install

# 4. アプリを起動する
$ ruby app.rb

# 5. [http://localhost:4567/](http://localhost:4567/) にアクセスできたらセットアップ完了です 👍
```

## リンターチェック
下記のコマンドを実行することで、各種スタイルのチェックを行うことができます。

```
# 1. Rubocop チェック
$ bundle exec rubocop

# 2. ERB Lint チェック
$ bundle exec erblint --lint-all
```

## その他
- 保存データは `memo_db.csv` ファイルに保存されていきます。
