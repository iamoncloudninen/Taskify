# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Devise関連のテスト', type: :system do
  let!(:user) do
    User.create(username: 'Test user', email: 'test@example.com', password: 'password123',
                password_confirmation: 'password123')
  end

  describe 'ユーザーのサインイン' do
    it '正しいメールアドレスとパスワードでサインインできること' do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password123'
      click_button 'ログイン'
      expect(page).to have_content('ログインしました')
    end
    it '無効なパスワードでサインインできないこと' do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'wrongpassword'
      click_button 'ログイン'
      expect(page).to have_content('無効なメールアドレスかパスワードです')
    end
  end

  describe 'ユーザーのサインアウト' do
    before do
      sign_in user
    end
    it 'ユーザーがサインアウトできること' do
      visit root_path
      find('.fa-sign-out-alt', match: :first).click
      expect(page).to have_content('ログアウトしました')
    end
  end

  describe 'ユーザーの新規登録' do
    it '新しいユーザーが新規登録できること' do
      visit new_user_registration_path
      fill_in 'ユーザー名', with: 'Test user'
      fill_in 'メールアドレス', with: 'newuser@example.com'
      fill_in 'パスワード(６文字以上)', with: 'password123'
      fill_in '確認用パスワード', with: 'password123'
      click_button '登録する'
      expect(page).to have_content('新規登録が完了しました')
    end
    it 'パスワード確認が一致しない場合、登録できないこと' do
      visit new_user_registration_path
      fill_in 'ユーザー名', with: 'Test user'
      fill_in 'メールアドレス', with: 'newuser@example.com'
      fill_in 'パスワード(６文字以上)', with: 'password123'
      fill_in '確認用パスワード', with: 'wrongpassword'
      click_button '登録する'
      expect(page).to have_content('パスワードと確認用パスワードが一致しません')
    end
  end
end
