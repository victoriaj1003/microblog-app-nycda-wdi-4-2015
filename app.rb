require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'byebug'

set :database, "sqlite3:lastminuteplans.sqlite3"
set :sessions, true

post '/follow/:id' do
	puts params.inspect
end
def current_user
	session[:user_id] ? User.find(session[:user_id]) : nil	
end


# when user types in our url, this goes to the server to get out ip address

get '/' do
	erb :home
end

#when user clicks the sign in link, they are directed to the signin page via this

get '/signin' do
	erb :signin
end

#from the sign in page, this will go to the database and compare email and password and if they verify, they are directed to their profile page via this, if their password doesn't verify, they are directed to sign up page

post '/signin' do
	@user = User.find_by(email: params[:email])
	if @user and @user.password == params[:password]
		session[:user_id] = @user.id
		puts "#{params.inspect}"
		# binding.pry
		redirect to('/profile')
	else
		redirect to('/signup')
	end
end

# *** does this duplicate line 29 above? ***
# get '/profile' do
# 	erb :profile
# end

#when the user clicks the sign up link they are directed to the sign up page via this

get '/signup' do
	erb :signup
end

#when the user clicks the submit button, the table is passed the user input info and a new record is created, then they are directed to their profile page

post '/signup' do
	@new_user=User.create(params[:user])
		# puts params.inspect #what does this do????
		session[:user_id] = @new_user.id
		puts "******* #{params.inspect} **********"
		redirect to('/profile')
end

get '/profile' do
	erb :profile
end

#when user searches from their profile page and hits search button, they are directed to their results page via this

get '/results' do
	erb :results
end

#adding a post and how it relates to the user... 
#user writes blog post and hits submit

post '/profile' do
	# @new_post=Post.create(title: params[:title], body: params[:body])
	Post.create(title: params[:title], body: params[:body])
	# puts "#{params.inspect}"
	redirect to('/profile')
end

# post '/profile' do
# 	@user=User.{:title }
# end

get '/exit' do
	erb :exit
end

# post '/exit' do
# 	@user.id = 
# 	session[:user_id] = nil
# 	redirect to('/exit')
# end

# post '/signin' do
# 	@user = User.find_by(email: params[:email])
# 	if @user and @user.password == params[:password]
# 		session[:user_id] = @user.id
# 		puts "#{params.inspect}"
# 		# binding.pry
# 		redirect to('/profile')
# 	else
# 		redirect to('/signup')
# 	end
# end

# for user to delete their account...

# Post '/.' do
# 	delete '/user/:id' do
# 		user = User.find(params[:id])
# 		user.destroy
# 		redirect to '/'
# 	end





