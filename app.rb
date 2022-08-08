# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'csv'
require './memo'
require 'erb'

# module Helper
module Helper
  def html_escape_helper(text)
    ERB::Util.html_escape(text)
  end

  module_function :html_escape_helper
end

####################
# View画面からの要求
####################
get '/' do
  @title = 'メモ帳 📋'
  @data_list = Memo.new.get
  erb :index
end

get '/new' do
  @title = 'メモ帳 📋 - 新規作成'
  erb :new
end

get '/show/:id' do |id|
  @title = 'メモ帳 📋 - 表示'
  @show_data = Memo.new.get_by_id(id)
  erb :show
end

get '/edit/:id' do |id|
  @title = 'メモ帳 📋 - 修正'
  @edit_data = Memo.new.get_by_id(id)
  erb :edit
end

not_found do
  erb :notfound
end

####################
# API呼び出し
####################
post '/api/memos' do
  title = Helper.html_escape_helper(params[:title])
  contents = Helper.html_escape_helper(params[:contents])
  Memo.new.create(title, contents)

  redirect '/'
  erb :index
end

patch '/api/memos/:id' do |id|
  title = Helper.html_escape_helper(params[:title])
  contents = Helper.html_escape_helper(params[:contents])
  Memo.new.update(id, title, contents)

  redirect '/'
  erb :index
end

delete '/api/memos/:id' do |id|
  Memo.new.delete(id)

  redirect '/'
  erb :index
end
