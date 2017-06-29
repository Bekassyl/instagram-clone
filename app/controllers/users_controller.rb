class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def destroy
    user = User.find(params[:id])
    if user.present?
      user.destroy
    end
    redirect_to root_path
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      redirect_to @user
    else
      render "edit"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      # @user.relationships.create(followed_id: @user)
      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :email, :password, :avatar, :bio)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
