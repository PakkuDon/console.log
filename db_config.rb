# Connect to database using Active Record
require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'consolelog'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
