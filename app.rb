require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models.rb"

set :database, "sqlite3:blogdb.squlite3"

enable :sessions


get '/profile/<% user_id %>' do
	
	erb :profile
end

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end