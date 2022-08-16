# frozen_string_literal: true

require 'pg'
require 'dotenv/load'

host = ENV['DATABASE_HOST']
user = ENV['DATABASE_USER']
pw = ENV['DATABASE_PASSWORD']
name = ENV['DATABASE_NAME']
port = ENV['DATABASE_PORT']

uri = "postgres://#{user}:#{pw}@#{host}:#{port}/#{name}"
conn = PG::Connection.new(uri)

sql1 = "CREATE TABLE memos (
  id SERIAL NOT NULL,
  title varchar(100),
  contents varchar(500)
);"
conn.exec(sql1)

sql2 = "INSERT INTO memos (title, contents) VALUES
('Linuxの設定', ''),
('GitHubの使い方', ''),
('Rubyの勉強', ''),
('カレンダープログラム', ''),
('ボーリングプログラム', ''),
('メモアプリプログラム', '');"
conn.exec(sql2)
