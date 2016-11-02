require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/post'
require_relative 'routes/init'

enable :sessions

helpers do
  # Return true if user logged in
  def logged_in?
    !!current_user
  end

  # Return true if item belongs to user
  def is_owner?(item)
    session[:user_id] == item.user_id
  end

  # Get current user
  def current_user
    User.find_by(id: session[:user_id])
  end
end

# -- Posts
# Return list of posts
get '/' do
  @q = params[:q]

  if @q
    @posts = Post.where("lower(title) LIKE ? OR lower(content) LIKE ?",
      "%#{@q.downcase}%", "%#{@q.downcase}%")
  else
    @posts = Post.all
  end
  @posts = @posts.order('date_posted desc')

  erb :index
end
