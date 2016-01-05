require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "carrierwave"
require "carrierwave/orm/activerecord"
require "mini_magick"
require "./models.rb"

set :database, "sqlite3:blogdb.squlite3"

enable :sessions

get '/sign_in' do
	erb :sign_in
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

get '/profile' do
	if session[:user_id]
		@user = current_user
		@post = Post.all
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
	#the !@post.save serves too purposes, it saves the post and runs the if statement to alert the user if the 
	#post was too long. It doesn't save if the post was too long/if the validation fails
	#it's part of the evaluation that active record does
	if !@post.save
		flash[:notice] = "Your post is too long, please try again"
	end
	redirect'/profile'
end

get '/logout' do
	session.clear
	redirect '/sign_in'
end

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end