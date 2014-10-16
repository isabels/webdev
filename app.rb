# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require
require './models/TodoItem'

ActiveRecord::Base.establish_connection(
	adapter: 'sqlite3',
	database: 'db/development.db',
	encoding: 'utf8' #unicode
)

get '/' do
	@tasks = TodoItem.all.order(:due_date) #do something to split on task and date
	erb :index
end

post '/' do
	TodoItem.create(params)
  	redirect '/'
end
