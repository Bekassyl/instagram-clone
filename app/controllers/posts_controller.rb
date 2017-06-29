class PostsController < ApplicationController
  before_action :check_signed_in, except: :show


  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def id
    @posts = Post.all
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = "Great, we were waiting for Your Post!"
      redirect_to @post
    else
      flash.now[:alert] = "Your Post isn't bananized enough! Please check the form."
      render "new"
    end
  end

  def edit
  end

  def destroy
    post = Post.find(params[:id])
    if post.present?
      post.destroy
    end
    redirect_to root_path
  end

  def like
    if @post.liked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:image, :description)
  end

  def check_signed_in
    redirect_to signin_path unless signed_in?
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
