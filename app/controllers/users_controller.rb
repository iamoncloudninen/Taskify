class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @timeline_posts = @user.timeline_post.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "ユーザーを削除しました。"
      redirect_to users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :profile_image)
  end
end
