require 'sinatra'
require 'sinatra/activerecord'
require 'mysql2'  # 追加

# データベースへの接続設定
set :database, {adapter: "mysql2", database: "db/development.db"}

# Userモデルの定義
class User < ActiveRecord::Base
end

get '/' do
  @title = "トップページ"
  erb :index
end

get '/about' do
  @title = "About Us"
  erb :about
end

post '/login' do
  # ログイン処理をここに記述
  login_id = params[:loginID]
  password = params[:password]
  # ログイン認証のロジックを実装
  redirect '/'
end



get '/hello/*' do |name|
  "hello #{name}. how are you?"
end
