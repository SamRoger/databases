require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
###############################################
set :database, "sqlite3:firstdb.sqlite3"
set :sessions, true
###############################################
require './models'
###############################################
get '/blog/:id' do
	@blog = Blog.find(params[:id])	

	erb :blog
end
#---------------------------------------------#
get '/' do
	erb :signup
end
#---------------------------------------------#
get '/login' do
	
	erb :login	
end
#---------------------------------------------#
get '/user_search' do
	@blogs = Blog.all
	@search = params[:search]
	@results = Blog.where(category:params[:search])
	
	erb :profile
end
#---------------------------------------------#
get '/profile' do
	current_user = User.find(session[:user_id])
	@blogs = current_user.blogs

	erb :profile
end
###############################################
post '/new_blog' do
	current_user = session[:user_id]

	Blog.create(title: params[:title], category: params[:category], content: params[:content], user_id: current_user)

	redirect '/profile'
end
#---------------------------------------------#
post '/new_user' do 
	User.create(username: params[:username], email: params[:email], password: params[:password])


	redirect '/login'
end
#---------------------------------------------#
post '/login' do
	user = User.where(email: params[:email]).first
	if user && user.password == params[:password]
		session[:user_id] = user.id

		redirect '/profile'
	else
		flash[:notice] = "Wrong User Name and/or Password"

		redirect '/login'
	end
end

post '/create_comment' do
	user = User.find(session[:user_id])
	blog = Blog.find(session[:blog_id])
	Comment.create(title: params[:comment_title], body: params[:comment_body], user_id:session[:user_id], blog_id:sessions[:blog_id])
end
































