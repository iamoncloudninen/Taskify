# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    before_action :protect_guest_user, only: %i[update destroy]

    def guest_sign_in
      user = User.guest_user
      sign_in user
      redirect_to dashboard_show_path(user.id), notice: 'ゲストユーザーとしてログインしました。'
    end

    def update; end

    def destroy; end

    private

    def protect_guest_user
      return unless current_user.guest?

      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end
end
