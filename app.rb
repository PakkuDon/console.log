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

end

# Create new post
post '/posts' do

end

# Show single post
get '/posts/:id' do

end

# Show edit post form
get '/posts/:id/edit' do

end

# Update post details
put '/posts/:id' do

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
