# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }
  describe 'バリデーションのテスト' do
    it 'メールアドレスとパスワードが必須であること' do
      expect(user).to validate_presence_of(:email)
      expect(user).to validate_presence_of(:password)
    end
    it 'メールアドレスがユニークであること' do
      duplicate_user = user.dup
      duplicate_user.email = duplicate_user.email.upcase
      expect(duplicate_user).not_to be_valid
    end
    it 'パスワードが6文字以上であること' do
      user.password = 'short'
      user.password_confirmation = 'short'
      expect(user).not_to be_valid
    end
    it 'パスワードと確認用パスワードが一致していること' do
      user.password = 'password123'
      user.password_confirmation = 'mismatch'
      expect(user).not_to be_valid
    end
    it 'パスワードが暗号化されて保存されること' do
      expect(user.encrypted_password).not_to eq('password123')
    end
  end

  describe 'アソシエーションのテスト' do
    it 'ユーザーが複数の関連するオブジェクトを持つこと' do
      expect(user).to have_many(:tasks).dependent(:destroy)
      expect(user).to have_many(:timeline_post).dependent(:destroy)
      expect(user).to have_many(:reactions).dependent(:destroy)
    end
  end
end
