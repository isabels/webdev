# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require

#change this for your stuff
get '/' do
	file_contents = File.read('todo.txt')
	@lines = file_contents.split("/n")
	# lines.each do |line|
	# 	task, due_date = line.split " - "
	# @items = "#{task} - #{due_date}"#creates the instance variable. somehow put to this??????
	erb :index
end

# post '/' do
# 	File.open("todo.txt", "a") do |file|
#     	file.puts "#{params[:task]} - #{params[:date]}"
#   	end
# end

#get '/99bottles' do
#  @lyrics = (1..99).to_a.reverse.map {|i| "#{i} bottles of beer on the wall, #{i} bottles of beer. Take one down, pass it around, #{i-1} bottles of beer on the wall."}
#  erb :bottles
#end