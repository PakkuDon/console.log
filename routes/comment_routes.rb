require_relative '../models/comment'

# -- Comments
# Add comment to post
post '/comments' do
  if logged_in?
    comment = Comment.new
    comment.content = params[:content]
    comment.post_id = params[:post_id]
    comment.date_posted = Time.new
    comment.user_id = current_user.id

    comment.save
  end
  redirect to "/posts/#{comment.post_id}"
end
