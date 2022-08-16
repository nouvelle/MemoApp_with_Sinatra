# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'csv'
require './memo'
require 'pg'
require 'dotenv/load'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

memo = Memo.new

####################
# View画面からの要求
####################
get '/' do
  @title = 'メモ帳 📋'
  @data_list = memo.all
  erb :index
end

get '/new' do
  @title = 'メモ帳 📋 - 新規作成'
  erb :new
end

get '/show/:id' do |id|
  @title = 'メモ帳 📋 - 表示'
  @show_data = memo.get_by_id(id)
  erb :show
end

get '/edit/:id' do |id|
  @title = 'メモ帳 📋 - 修正'
  @edit_data = memo.get_by_id(id)
  erb :edit
end

not_found do
  erb :notfound
end

####################
# API呼び出し
####################
post '/api/memos' do
  memo.create(params[:title], params[:contents])

  redirect '/'
  erb :index
end

patch '/api/memos/:id' do |id|
  memo.update(id, params[:title], params[:contents])

  redirect '/'
  erb :index
end

delete '/api/memos/:id' do |id|
  memo.delete(id)

  redirect '/'
  erb :index
end
