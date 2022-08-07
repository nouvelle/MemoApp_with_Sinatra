require "sinatra"
require "sinatra/reloader"
require "csv"

def memo
  @memo = Memo.new
end

get "/" do
  @data_list = CSV.read("./memo_db.csv").sort
  erb :index
end

get "/new" do
  erb :new
end

get "/show/:id" do |id|
  data_list = CSV.read("./memo_db.csv")
  data_list.each do |data|
    @show_data = data if data[0] == id
  end
  erb :show
end

get "/edit/:id" do |id|
  data_list = CSV.read("./memo_db.csv")
  data_list.each do |data|
    @edit_data = data if data[0] == id
  end
  erb :edit
end

# get "/delete" do
#   erb :delete
# end

# get "/api/memos" do
#   "Hello"
# end

post "/api/memos" do
  @id = params[:id]
  @title = params[:title]
  @contents = params[:contents]

  memos = CSV.read("./memo_db.csv")
  memos.delete_if { |array| array[0] == @id}

  CSV.open("./memo_db.csv","w") do |csv|
    memos.each do |array|
      csv << array
    end
    csv << [@id, @title, @contents]
  end

  redirect "/"
  erb :index
end

patch "/api/memos/:id" do |id|
  @title = params[:title]
  @contents = params[:contents]

  memos = CSV.read("./memo_db.csv")
  memos.delete_if { |array| array[0] == id}

  CSV.open("./memo_db.csv","w") do |csv|
    memos.each do |array|
      csv << array
    end
    csv << [id, @title, @contents]
  end

  redirect "/"
  erb :index
end

# get "/api/memos/:id" do |id|
#   "This is #{id}'s memo."
# end

# put "/api/memos/:id" do |id|
#   # 何か更新
# end


delete "/api/memos/:id" do |id|
  memos = CSV.read("./memo_db.csv")
  memos.delete_if { |array| array[0] == id}

  CSV.open("./memo_db.csv","w") do |csv|
    memos.each do |array|
      csv << array
    end
  end

  redirect "/"
  erb :index
end

# get "/hello/:name" do
#   # "GET /hello/foo" と "GET /hello/bar" にマッチ
#   # params["name"] は "foo" か "bar"
#   "Hello #{params["name"]}!"
# end

# get "/hello/:name" do |n|
#   # params[]をいちいち書くのが面倒な時
#   "Hello #{n}!"
# end

# get "/foo", :agent => /Songbird (\d\.\d)[\d\/]*?/ do
#   "Songbirdのバージョン #{params["agent"][0]}を使ってます。"
# end

# get "/foo" do
#   # Songbird以外のブラウザにマッチ
# end