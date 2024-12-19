class Users::SessionsController < Devise::SessionsController
    before_action :protect_guest_user, only: [:update, :destroy]

    def guest_sign_in
      user = User.guest_user
      sign_in user
      redirect_to dashboard_show_path(user.id), notice: "ゲストユーザーとしてログインしました。"
    end

    private
  
    def protect_guest_user
      if current_user.guest?
        redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
      end
    end
  end
  
