require 'sinatra'
require 'redcarpet'
require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/post'
require_relative 'models/follow'
require_relative 'routes/init'

enable :sessions

helpers do
  # Return true if user logged in
  def logged_in?
    !!current_user
  end

  # Return true if item belongs to user
  def is_owner?(item)
    current_user_id == item.user_id
  end

  # Get current user ID
  def current_user_id
    session[:user_id]
  end

  # Get current user
  def current_user
    User.find_by(id: current_user_id)
  end

  # Return true if user has liked post
  def liked?(post)
    logged_in? &&
      current_user.likes.where(post_id: post.id).any?
  end

  # Return true if current user is following given user
  def following?(user)
    logged_in? && current_user.followees.where(id: user.id).any?
  end

  # Escape HTML characters
  def escape_html(str)
    CGI::escape_html(str)
  end

  # Convert markdown to HTML
  def render_markdown(str)
    renderer = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(hard_wrap: true),
      autolink: true, tables: true)
    renderer.render(str)
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
