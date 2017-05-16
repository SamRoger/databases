require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

enable :sessions


set :database, "sqlite3:firstdb.sqlite3"

require './models'

get '/' do
	@blogs = Blog.all
	erb :index
end

post '/new_blog' do
	Blog.create(title: params[:title], category: params[:category], content: params[:content])
	redirect '/'
end

get '/user_search' do
	@blogs = Blog.all
	@search = params[:search]
	@results = Blog.where(category:params[:search])
	
	erb :index
end