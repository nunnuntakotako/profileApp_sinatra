require 'sinatra'
require 'sinatra/activerecord'
require 'sqlite3'
require 'bcrypt'
require 'rack-flash' #Gemfileはrack-flash3

enable :sessions
use Rack::Flash

# データベースへの接続設定
set :database, {adapter: "sqlite3", database: "db/schema.db"}


# Userモデルの定義
class User < ActiveRecord::Base
  has_secure_password
end

# 初期データの登録（実行は一度だけ）
# User.create(login_id: 'root', password: 'root')

get '/' do
  @title = "トップページ"
  erb :index
end

get '/about' do
  @title = "About Us"
  erb :about
end

use Rack::Flash

# ログイン処理
post '/login' do
  user = User.find_by(login_id: params[:loginID])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    flash[:success] = 'ログイン成功！'
    redirect '/hello/world'
  else
    flash[:error] = 'ログイン失敗！'
    redirect '/'
  end
end

# ログイン状態の確認
get '/hello/*' do |name|
  if session[:user_id]
    "Hello, #{name}! You are logged in."
  else
    redirect '/'
  end
end
