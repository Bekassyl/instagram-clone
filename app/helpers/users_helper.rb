module UsersHelper

  def follows?(user)
    if current_user.following?(user)
      render "partials/unfollow", user: user
    else
      render "partials/follow", user: user
    end
  end

  def likes?(post)
    if current_user.liking?(post)
      render "partials/dislike", post: post
    else
      render "partials/like", post: post
    end
  end


end
