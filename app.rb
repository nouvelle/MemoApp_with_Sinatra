require "sinatra"
require "sinatra/reloader"
require "csv"

def memo
  @memo = Memo.new
end

get "/" do
  @title = "メモ帳 📋"
  @data_list = CSV.read("./memo_db.csv").sort
  erb :index
end

get "/new" do
  @title = "メモ帳 📋 - 新規作成"
  erb :new
end

get "/show/:id" do |id|
  @title = "メモ帳 📋 - 表示"
  data_list = CSV.read("./memo_db.csv")
  data_list.each do |data|
    @show_data = data if data[0] == id
  end
  erb :show
end

get "/edit/:id" do |id|
  @title = "メモ帳 📋 - 修正"
  data_list = CSV.read("./memo_db.csv")
  data_list.each do |data|
    @edit_data = data if data[0] == id
  end
  erb :edit
end

post "/api/memos" do
  @title = params[:title]
  @contents = params[:contents]

  memos = CSV.read("./memo_db.csv")
  id = memos.map { |array| array[0] }.max

  CSV.open("./memo_db.csv","a") do |csv|
    csv << [id.to_i + 1, @title, @contents]
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

not_found do
  erb :notfound
end
