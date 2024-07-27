require 'sequel'

DB = Sequel.connect('postgres://user:password@host:port/database')

class User < Sequel::Model(DB)
  # テーブルのカラム定義
  plugin :validation_helpers
  plugin :timestamps

  # バリデーション
  def validate
    super
    validates_presence [:name, :email]
    validates_unique [:email]
  end
end