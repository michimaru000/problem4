class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user_id = User.find(params[:id])  
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user_id.books    
  end
  
  def index
    @users = User.all  
    @user = current_user
    @book = Book.new
  end

  def edit
   
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path,notice:'user update successfully'
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
   
end
