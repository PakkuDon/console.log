require_relative '../models/follow'
require_relative '../models/user'

# Add followee to current user
post '/follows' do
  if logged_in?
    follow = Follow.new
    follow.date_followed = Time.new
    follow.follower_id = current_user_id
    follow.followee_id = params[:user_id]
    follow.save
  end

  redirect to "/users/#{User.find_by(id: params[:user_id]).username}"
end

# Remove followee from current user
delete '/follows' do
  if logged_in?
    follow = Follow.find_by(
      follower_id: current_user_id,
      followee_id: params[:user_id]
    )

    if follow
      follow.destroy
    end
  end
  redirect to "/users/#{User.find_by(id: params[:user_id]).username}"
end
