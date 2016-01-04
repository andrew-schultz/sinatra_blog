require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"

set :database, "sqlite3:blogdb.squlite3"

enable :sessions