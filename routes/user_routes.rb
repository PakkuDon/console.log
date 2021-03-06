require_relative '../models/user'
require_relative '../models/follow'

# -- Users
# Show registration form
get '/users/new' do
  # Redirect if logged in
  if logged_in?
    redirect to '/'
  end

  erb :user_new
end

# Create new user
post '/users' do
  # Redirect if logged in
  if logged_in?
    redirect to '/'
  end

  @user = User.new
  @user.username = params[:username]
  @user.email = params[:email]
  @user.password = params[:password]
  @user.date_joined = Time.new

  # If user created, authenticate user
  # and redirect to home
  if @user.save
    session[:user_id] = @user.id
    redirect to '/'
  else
    erb :user_new
  end
end

# Show user profile
get '/users/:username' do
  @user = User.find_by(username: params[:username])

  if @user
    @user.posts = @user.posts.order('date_posted desc')
    erb :user_view
  else
    @error = 'User not found'
    erb :error
  end
end

# Show users following user
get '/users/:username/followers' do
  user = User.find_by(username: params[:username])

  if user
    @followers = user.followers
    erb :followers_view
  else
    @error = 'User not found'
    erb :error
  end
end

# Show users followed by user
get '/users/:username/followees' do
  user = User.find_by(username: params[:username])

  if user
    @followees = user.followees
    erb :followees_view
  else
    @error = 'User not found'
    erb :error
  end
end

# Show login form
get '/session/new' do
  # Redirect if logged in
  if logged_in?
    redirect to '/'
  end

  erb :session_new
end

# Authenticate user
post '/session' do
  # Redirect if logged in
  if logged_in?
    redirect to '/'
  end

  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/'
  else
    @error = 'Invalid email or password'
    erb :session_new
  end
end

# Log user out
delete '/session' do
  # Redirect if not logged in
  if !logged_in?
    redirect to '/'
  end

  session[:user_id] = nil
  redirect to '/'
end
