require_relative '../models/like'

# Add like for current user to selected post
post '/likes' do
  post_id = params[:post_id]

  if logged_in? && post_id
    like = Like.new
    like.date_liked = Time.new
    like.post_id = post_id
    like.user_id = current_user_id
    like.save
  end

  redirect to "/posts/#{post_id}"
end

# Unlike post for current user
delete '/likes' do
  post_id = params[:post_id]

  if logged_in? && post_id
    like = Like.find_by(
      user_id: current_user_id,
      post_id: post_id
    )

    if like
      like.destroy
    end
  end

  redirect to "/posts/#{post_id}"
end
