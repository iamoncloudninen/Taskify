# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TimelinePosts', type: :request do
  let(:user) do
    User.create(username: 'Test user', email: 'test@example.com', password: 'password123',
                password_confirmation: 'password123')
  end
  let(:task) do
    user.tasks.create(content: 'Test task', deadline: Time.zone.now.end_of_day, priority: true, completed: true,
                      completed_at: Time.zone.now)
  end
  let(:timeline_post) { TimelinePost.create(content: 'Test timeline post', user: user, tasks: [task]) }

  before do
    sign_in user
  end

  describe 'ページ表示に関するテスト' do
    it 'タイムラインページが表示されること' do
      get timeline_index_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include('タイムライン')
    end
    it '投稿作成ページが表示されること' do
      get new_timeline_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include('タスク達成投稿の作成')
    end
  end

  describe '投稿作成についてのテスト' do
    context '有効なパラメータの場合' do
      it '投稿を作成できること' do
        timeline_post_params = {
          timeline_post: {
            content: 'Test timeline post',
            task_ids: [task.id]
          }
        }
        expect do
          post timeline_index_path, params: timeline_post_params
        end.to change(TimelinePost, :count).by(1)
        expect(response).to redirect_to(timeline_index_path)
        follow_redirect!
        expect(response.body).to include('投稿が成功しました！')
      end
    end

    context '無効なパラメータの場合' do
      it '投稿を作成できないこと' do
        timeline_post_params = {
          timeline_post: {
            content: '',
            task_ids: []
          }
        }
        expect do
          post timeline_index_path, params: timeline_post_params
        end.not_to change(TimelinePost, :count)
        expect(response).to render_template(:new)
        expect(response.body).to include('投稿に失敗しました。入力内容を確認してください。')
      end
    end
  end

  describe '投稿の削除についてのテスト' do
    it '投稿を削除できること' do
      timeline_post
      expect do
        delete timeline_path(timeline_post)
      end.to change(TimelinePost, :count).by(-1)
      expect(response).to redirect_to(timeline_index_path)
      follow_redirect!
      expect(response.body).to include('投稿を削除しました。')
    end
  end
end
