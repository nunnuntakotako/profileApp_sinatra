# Rakefile

require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

namespace :db do
  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/development.db'
    )
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate('db/migrate')
  end

  desc "Create a new migration file"
  task :create_migration do
    name = ENV["NAME"]
    abort("no NAME specified. use `rake db:create_migration NAME=create_users`") if !name

    migrations_dir = File.join('db', 'migrate')
    version = ENV["VERSION"] || Time.now.utc.strftime("%Y%m%d%H%M%S")
    filename = "#{version}_#{name}.rb"
    migration_file = File.join(migrations_dir, filename)

    if File.exist?(migration_file)
      abort("Migration already exists: #{migration_file}")
    end

    migration_template = File.join(File.dirname(__FILE__), 'db', 'templates', 'migration.erb')
    contents = ERB.new(File.read(migration_template)).result(binding)

    File.open(migration_file, 'w') { |f| f.write(contents) }

    puts "Created migration #{migration_file}"
  end
end
