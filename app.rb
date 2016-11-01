require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/post'
require_relative 'models/comment'

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

end

# -- Comments
# Add comment to post
post '/comments' do

end

# -- Users
# Show login form
get '/session/new' do

end

# Authenticate user
post '/session' do

end

# Log user out
delete '/session' do

end
