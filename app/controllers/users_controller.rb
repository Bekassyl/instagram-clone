class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy, :edit, :update]

  def index
    @users = User.all
  end

  def show

  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    if	@user.update_attributes(user_params)
			redirect_to	@user
		else
			render	"edit"
		end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
