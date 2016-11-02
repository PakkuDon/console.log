require_relative '../models/comment'
require_relative '../models/post'

# -- Comments
# Add comment to post
post '/comments' do
  if logged_in?
    @comment = Comment.new
    @comment.content = params[:content]
    @comment.post_id = params[:post_id]
    @comment.date_posted = Time.new
    @comment.user_id = current_user.id

    if @comment.save
      redirect to "/posts/#{@comment.post_id}"
    else
      @post = Post.find_by(id: params[:post_id])
      erb :post_view
    end
  end
end
