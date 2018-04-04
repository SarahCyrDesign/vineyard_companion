ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :database => "mydb"
)

require_all 'app'


# :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
