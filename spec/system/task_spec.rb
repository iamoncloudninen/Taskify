require 'rails_helper'

RSpec.describe 'タスク', type: :system do
  let(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

  before do
    sign_in user
  end

  describe 'タスクの作成' do
    it '新しいタスクを作成できること' do
      visit new_task_path
      fill_in 'タスク内容', with: '新しいタスク'
      fill_in '期限', with: Time.zone.now.end_of_day
      check '優先'
      click_button 'タスクを作成する'
      expect(page).to have_content('新しいタスク')
    end
  end

  describe 'タスクの編集' do
    let!(:task) { user.tasks.create(content: '編集前のタスク', deadline: Time.zone.now.end_of_day, priority: false) }
    it 'タスクを編集できること' do
      visit edit_task_path(task)
      fill_in 'タスク内容', with: '編集後のタスク'
      check '優先'
      click_button 'タスクを更新する'
      expect(page).to have_content('編集後のタスク')
    end
  end

  describe 'タスクの削除' do
    let!(:task) { user.tasks.create(content: '削除するタスク', deadline: Time.zone.now.end_of_day, priority: false) }
    it 'タスクを削除できること' do
      visit dashboard_show_path
      page.accept_confirm do
        find('.fa-trash', match: :first).click
      end
      expect(page).not_to have_content('削除するタスク')
    end
  end

  describe 'タスクの達成' do
    let!(:task) { user.tasks.create(content: '未達成のタスク', deadline: Time.zone.now.end_of_day, priority: false, completed: false) }
    it 'タスクを達成済みに変更できること' do
      visit dashboard_show_path
      page.accept_confirm do
        find('.btn-complete', match: :first).click
      end
      expect(page).to have_content('未達成のタスク')
    end
  end

  describe 'タスクの未達成' do
    let!(:task) { user.tasks.create(content: '達成済みのタスク', deadline: Time.zone.now.end_of_day, priority: false, completed: true, completed_at: Time.zone.now.beginning_of_day) }
    it 'タスクを未達成に変更できること' do
      visit dashboard_show_path
      page.accept_confirm do
        find('.btn-complete', match: :first).click
      end
      expect(page).to have_content('達成済みのタスク')
    end
  end
end
