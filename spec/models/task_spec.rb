# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) do
    User.create(username: 'Test user', email: 'test@example.com', password: 'password123',
                password_confirmation: 'password123')
  end
  let(:task) { user.tasks.create(content: 'Test task', deadline: 1.week.from_now, priority: true) }

  describe 'バリデーションのテスト' do
    describe 'タスク名と期限' do
      it 'タスク名と期限が必須であること' do
        expect(task).to validate_presence_of(:content)
        expect(task).to validate_presence_of(:deadline)
      end

      it 'タスク名が255文字以内であること' do
        task.content = 'a' * 256
        expect(task).not_to be_valid
      end
    end

    describe '優先' do
      it '優先がtrueまたはfalseであること' do
        task.priority = nil
        expect(task).not_to be_valid
        task.priority = true
        expect(task).to be_valid
        task.priority = false
        expect(task).to be_valid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    describe 'ユーザーとの関連' do
      it 'タスクがユーザーに属すること' do
        expect(task).to belong_to(:user)
      end
    end

    describe 'タイムライン投稿との関連' do
      it 'タスクが複数の投稿を持つこと' do
        expect(task).to have_many(:task_timeline_posts).dependent(:destroy)
        expect(task).to have_many(:timeline_posts).through(:task_timeline_posts)
      end
    end
  end
end
