# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }
  let(:task) { user.tasks.create(content: 'Test task', deadline: Time.zone.now.end_of_day, priority: true) }

  before do
    sign_in user
  end

  describe 'ページ表示に関するテスト' do
    it 'タスク作成ページが表示されること' do
      get new_task_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include('タスク作成')
    end
  end

  describe 'タスクの作成についてのテスト' do
    context '有効なパラメータの場合' do
      it 'タスクを作成できること' do
        task_params = {
          task: {
            content: 'New task',
            deadline: Time.zone.now.end_of_day,
            priority: true
          }
        }
        expect do
          post tasks_path, params: task_params
        end.to change(Task, :count).by(1)
        expect(response).to redirect_to(dashboard_show_path)
        follow_redirect!
        expect(response.body).to include('タスクを作成しました')
      end
    end

    context '無効なパラメータの場合' do
      it 'タスクを作成できないこと' do
        task_params = {
          task: {
            content: '',
            deadline: '',
            priority: ''
          }
        }
        expect do
          post tasks_path, params: task_params
        end.not_to change(Task, :count)
        expect(response).to render_template(:new)
        expect(response.body).to include('タスクの作成に失敗しました')
      end
    end
  end

  describe 'タスクの更新についてのテスト' do
    it 'タスクを更新できること' do
      updated_params = {
        task: {
          content: 'Updated task',
          deadline: Time.zone.now.end_of_day,
          priority: true
        }
      }
      put task_path(task), params: updated_params
      task.reload
      expect(task.content).to eq('Updated task')
      expect(task.priority).to eq(true)
      expect(response).to redirect_to(dashboard_show_path)
      follow_redirect!
      expect(response.body).to include('タスクを更新しました')
    end
  end

  describe 'タスクの達成についてのテスト' do
    it 'タスクを達成できること' do
      patch complete_task_path(task)
      task.reload
      expect(task.completed).to be(true)
      expect(task.completed_at).not_to be_nil
      expect(response).to redirect_to(dashboard_show_path)
      follow_redirect!
      expect(response.body).to include('タスクを達成しました')
    end
  end

  describe 'タスクの未達成についてのテスト' do
    before do
      task.update(completed: true, completed_at: Time.zone.now)
    end
    it 'タスクを未達成に戻せること' do
      patch incomplete_task_path(task)
      task.reload
      expect(task.completed).to be(false)
      expect(task.completed_at).to be_nil
      expect(response).to redirect_to(dashboard_show_path)
      follow_redirect!
      expect(response.body).to include('タスクを未達成に戻しました')
    end
  end

  describe 'タスクの削除についてのテスト' do
    it 'タスクを削除できること' do
      task
      expect do
        delete task_path(task)
      end.to change(Task, :count).by(-1)
      expect(response).to redirect_to(dashboard_show_path)
      follow_redirect!
      expect(response.body).to include('タスクを削除しました')
    end
  end
end
