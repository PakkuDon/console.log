require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/post'
require_relative 'models/comment'

enable :sessions

helpers do
  # Return true if user logged in
  def logged_in?
    !!current_user
  end

  # Get current user
  def current_user
    User.find_by(id: session[:user_id])
  end
end

# -- Posts
# Return list of posts
get '/' do
  @posts = Post.all
  erb :index
end

# Show create post form
get '/posts/new' do
  erb :post_new
end

# Create new post
post '/posts' do
  post = Post.new
  post.title = params[:title]
  post.content = params[:content]
  post.date_posted = Time.new
  post.view_count = 0
  # TODO: Change ID to current user
  post.user_id = 1

  if post.save
    redirect to "/posts/#{post.id}"
  else
    erb :post_new
  end
end

# Show single post
get '/posts/:id' do
  @post = Post.find_by(id: params[:id])
  if @post
    # Update view count
    @post.view_count += 1
    @post.save
    erb :post_view
  else
    @error = 'Post not found.'
    erb :error
  end
end

# Show edit post form
get '/posts/:id/edit' do
  @post = Post.find_by(id: params[:id])
  if @post
    erb :post_edit
  else
    @error = 'Post not found.'
    erb :error
  end
end

# Update post details
put '/posts/:id' do
  @post = Post.find_by(id: params[:id])
  if @post
    @post.title = params[:title]
    @post.content = params[:content]

    if @post.save
      redirect to "/posts/#{@post.id}"
    else
      erb :post_edit
    end
  else
    @error = 'Post not found.'
    erb :error
  end
end

# Delete post
delete '/posts/:id' do
  @post = Post.find_by(id: params[:id])

  if @post
    @post.destroy
    redirect to '/'
  else
    @error = 'Post not found.'
    erb :error
  end
end

# -- Comments
# Add comment to post
post '/comments' do

end

# -- Users
# Show registration form
get '/users/new' do
  erb :user_new
end

# Create new user
post '/users' do
  user = User.new
  user.username = params[:username]
  user.email = params[:email]
  user.password = params[:password]
  user.date_joined = Time.new

  # If user created, authenticate user
  # and redirect to home
  if user.save
    session[:user_id] = user.id
    redirect to '/'
  else
    erb :user_new
  end
end

# Show login form
get '/session/new' do
  erb :session_new
end

# Authenticate user
post '/session' do
  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/'
  else
    erb :session_new
  end
end

# Log user out
delete '/session' do
  session[:user_id] = nil
  redirect to '/'
end
