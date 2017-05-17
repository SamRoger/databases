require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
###############################################
set :database, "sqlite3:firstdb.sqlite3"
set :sessions, true
###############################################
require './models'
###############################################
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
	@user = User.find(1)
	@blogs = @user.blogs

	erb :profile
end
###############################################
post '/new_blog' do
	Blog.create(title: params[:title], category: params[:category], content: params[:content])

	redirect '/profile'
end
#---------------------------------------------#
post '/new_user' do 
	User.create(username: params[:username], email: params[:email], password: params[:password])


	redirect '/login'
end
#---------------------------------------------#
post '/login' do
	user = User.where(username: params[:username]).first
	if user.password == params[:password]
		session[:user_id] = user.id

		redirect '/profile'
	else
		flash[:notice] = "Wrong User Name and/or Password"

		redirect '/login'
	end
end








