require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "carrierwave"
require "carrierwave/orm/activerecord"
require "mini_magick"
require "./models.rb"

set :database, "sqlite3:blogdb.squlite3"

enable :sessions

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end

get '/sign_in' do 
	erb :sign_in, :layout => false 
end

post '/sign_in' do
	@user = User.where(username: params[:username]).first
	puts params[:password]
	if @user && @user.password == params[:password]
		session[:user_id] = @user.id
		flash[:notice] = "You've been signed in successfully"
	else
		flash[:notice] = "You're username or password doesn't match our records, please try again"
	end

	redirect '/profile'
end

post '/sign_up' do
	@user1 = User.new(fname: params[:fname], lname: params[:lname],username: params[:username],password: params[:password])
	@user1.save
	redirect'/profile'
end

get '/profile' do
	if session[:user_id]
		@user = current_user
		@post = Post.last(10)
		erb :profile
	else
		redirect '/sign_in'
	end
end

post '/profile' do
	puts params.inspect
	#set an instance variable equal to the new post that is created by passing the parameters from the form
	@post = Post.new(title: params[:ptitle], body: params[:newpost], user_id: current_user.id)
	#use an if statement to utitlize the validation method (in method.rb)
	#the !@post.save serves two purposes, it saves the post and runs the if statement to alert the user if the 
	#post was too long. It doesn't save if the post was too long/if the validation fails
	#it's part of the evaluation that active record does
	if !@post.save
		flash[:notice] = "Your post is too long, please try again"
	end
	redirect'/profile'
end

get '/account' do
	@user = current_user
	@posts = Post.where(user_id: @user.id)
	erb :account
end

post '/account' do
	@user = current_user
	@user.update(fname: params[:fname], lname: params[:lname], username: params[:username], password: params[:password], bio: params[:bio])
	redirect '/account'
end

post '/edit' do
	@post = Post.find_by(id: params[:id])
	@post.update(body: params[:body], title: params[:title])
	redirect '/account'
end

get '/logout' do
	session.clear
	redirect '/sign_in'
end

get '/' do
	redirect '/sign_in'
end

get '/users' do
	erb :users
end
