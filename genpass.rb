require 'digest/sha2'
require 'sinatra/activerecord'

ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection :development

class Account < ActiveRecord::Base
end
 
#基本情報
username = "mob"
rawpasswd = "mob"
algorithm = "3"
r = Random.new
salt = Digest::SHA256.hexdigest(r.bytes(20))
hashed = Digest::SHA256.hexdigest(rawpasswd + salt)

puts "salt = #{salt}"
puts "username = #{username}"
puts "raw password =#{rawpasswd}"
puts "algorithm = #{algorithm}"
puts "hashed passwd = #{hashed}"

#データベースを更新する
s = Account.new
s.id = username
s.salt = salt
s.hashed = hashed
s.algo = algorithm
s.save

#データベースの中身を出力する
@c = Account.all
@c.each do |a|
  puts a.id
  puts a.salt
  puts a.hashed
  puts a.algo
end