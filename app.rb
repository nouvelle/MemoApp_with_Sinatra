require "sinatra"
require "sinatra/reloader"

get "/memos" do
  "Hello, Sinatra"
end

post "/memos" do
  # 何か生成
end

get "/memos/:id" do |id|
  "This is #{id}'s memo."
end

put "/memos/:id" do |id|
  # 何か更新
end

patch "/memos/:id" do |id|
  # 何か修正
end

delete "/memos/:id" do |id|
  # 何か削除
end

get "/hello/:name" do
  # "GET /hello/foo" と "GET /hello/bar" にマッチ
  # params["name"] は "foo" か "bar"
  "Hello #{params['name']}!"
end

get "/hello/:name" do |n|
  # params[]をいちいち書くのが面倒な時
  "Hello #{n}!"
end

get '/foo', :agent => /Songbird (\d\.\d)[\d\/]*?/ do
  "Songbirdのバージョン #{params['agent'][0]}を使ってます。"
end

get '/foo' do
  # Songbird以外のブラウザにマッチ
end