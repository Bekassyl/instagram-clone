module UsersHelper

  def follows?(user)
    if current_user.following?(user)
      render "partials/unfollow", user: user
    else
      render "partials/follow", user: user
    end
  end


end
