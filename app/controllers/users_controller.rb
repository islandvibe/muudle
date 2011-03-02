class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def destroy
    User.find_by_name(params[:id]).destroy
    flash[:success] = "User removed."
    redirect_to :back
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find_by_name(params[:id])
    @title = @user.name
    @micropost = Micropost.new if user_signed_in?
    @microposts = @user.microposts.paginate(:page => params[:page], :per_page => 6)
  end

  def name_redirect
     redirect_to users_path(@user)
  end
end
