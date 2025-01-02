# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

  describe '新規登録のテスト' do
    context '有効なパラメータの場合' do
      it '新規登録に成功すること' do
        user_params = {
          user: {
            email: 'test@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
        expect do
          post user_registration_path, params: user_params
        end.to change(User, :count).by(1)
        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(dashboard_show_path)
      end
    end
    context '無効なパラメータの場合' do
      it '新規登録に失敗すること' do
        user_params = {
          user: {
            email: 'test@example.com',
            password: 'password123',
            password_confirmation: 'wrongpassword'
          }
        }
        expect do
          post user_registration_path, params: user_params
        end.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('パスワードと確認用パスワードが一致しません')
      end
    end
  end

  describe 'ログインのテスト' do
    it 'ログインに成功すること' do
      sign_in user
      post user_session_path, params: { user: { email: 'test@example.com', password: 'password123' } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(dashboard_show_path)
    end
    it 'ログインに失敗すること' do
      post user_session_path, params: { user: { email: 'test@example.com', password: 'wrongpassword' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).not_to redirect_to(dashboard_show_path)
    end
  end

  describe 'ログアウトのテスト' do
    it 'ログアウトができること' do
      sign_in user
      delete destroy_user_session_path
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(root_path)
    end
  end

  describe '認証が必要なものに関するテスト' do
    context 'ログインしていない場合' do
      it 'アクセスできないこと' do
        get dashboard_show_path
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('ログインか新規登録が必要です')
      end
    end

    context 'ログインしている場合' do
      it 'アクセスできること' do
        sign_in user
        get dashboard_show_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
