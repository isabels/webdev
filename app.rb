# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require
require './models/TodoItem'
require './models/User'

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
	@users = User.all.order(:name)
	erb :user_list
end

post '/create_user' do
	User.create(params)
	redirect '/'
end

post '/delete_user/:user' do
	User.find_by(name: params[:user]).destroy
	redirect '/'
end

####

get '/users/:name' do
	@user = User.find_by(name: params[:name])
	@tasks = TodoItem.find_by(user_id: user.id)
	erb :item_list
end

# post '/' do
# 	TodoItem.create(params)
#   	redirect '/'
# end

post '/:user_id/create_item' do
	@user = User.find(params[:user_id])
	TodoItem.create(user: @user, description: params[:description], due: params[:due])
	redirect '/users/#{@user}'
end



post '/delete/:user/:item' do
	TodoItem.find(params[:item]).destroy
	redirect '/users/:user'
end

post '/users/:name' do
	redirect '/users/:name'
end

###
# post '/some_endpoint' do
#   some_user_data = params[:some_user_data]
#   some_constant_data = params[:some_constant_data]
#   # do some action with that data
# end
