class LikesController < ApplicationController
  def create
    current_user.like(params[:post_id)
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.js {}
    end
  end

  def destroy
    current_user.dislike(params[:post_index])
    @post = Post.find(params[:post_index])
    respond_to do |format|
      format.js {}
    end
  end
end
