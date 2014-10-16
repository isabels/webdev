# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require
require './models/TodoItem'

if ENV['DATABASE_URL']
	ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
	ActiveRecord::Base.establish_connection(
		:adapter => 'sqlite3',
		:database => 'db/development.db',
		:encoding => 'utf8'
	)
end

get '/' do
	@tasks = TodoItem.all.order(:due_date) #do something to split on task and date
	erb :index
end

post '/' do
	TodoItem.create(params)
  	redirect '/'
end
