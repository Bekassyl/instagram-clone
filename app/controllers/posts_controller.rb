class PostsController < ApplicationController
  before_action :check_signed_in, except: :show


  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      redirect_to @post
    else
      render "new"
    end
  end

  def edit
  end

  private
  def post_params
    params.require(:post).permit(:image, :description)
  end

  def check_signed_in
    redirect_to signin_path unless signed_in?
  end

end
