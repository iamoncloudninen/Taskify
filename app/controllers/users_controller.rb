class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def show
    if params[:id] == "guest_sign_in"
      @user = User.guest_user
    else
      @user = User.find(params[:id])
    end
    @timeline_posts = @user.timeline_post.order(created_at: :desc)
  end  

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました。"
    else
      render :edit, alert: "更新に失敗しました。"
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "ユーザーを削除しました。"
    redirect_to root_path
  end

  private

  def set_user
    @user = params[:id] == "guest_sign_in" ? User.guest_user : User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :profile_image)
  end
end
