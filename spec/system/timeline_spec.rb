require 'rails_helper'

RSpec.describe 'タイムライン', type: :system do
  let(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }
  let!(:task) { user.tasks.create(content: '本日達成したタスク', deadline: Time.zone.now.end_of_day, priority: false, completed: true, completed_at: Time.zone.now.beginning_of_day) }
  let!(:timeline_post) { TimelinePost.create(content: '削除する投稿', user: user, tasks: [task]) }

  before do
    sign_in user
  end

  describe 'タイムライン投稿のテスト' do
    context 'タスクを選択した場合' do
      it '投稿を作成できること' do
        visit new_timeline_path
        expect(page).to have_selector("input[type='checkbox'][id='timeline_post_task_ids_#{task.id}']")
        check "timeline_post_task_ids_#{task.id}"
        fill_in 'コメント', with: 'Test timeline post'
        click_button '投稿する'
        expect(page).to have_content('投稿が成功しました！')
        expect(page).to have_content('Test timeline post')
      end
    end
    context 'タスクを選択しなかった場合' do
      it 'エラーが表示されること' do
        visit new_timeline_path
        fill_in 'コメント', with: 'Test timeline post'
        click_button '投稿する'
        expect(page).to have_content('少なくとも1つのタスクを選択してください')
      end
    end
  end

  describe '投稿の削除' do
    it 'タスクを削除できること' do
      visit timeline_index_path
      page.accept_confirm do
        find('.fa-trash', match: :first).click
      end
      expect(page).not_to have_content('削除する投稿')
    end
  end
end
