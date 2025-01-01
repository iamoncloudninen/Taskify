RSpec.describe TimelinePost, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }
  let(:task) { user.tasks.create(content: 'Test task', deadline: 1.week.from_now, priority: true) }
  let(:timeline_post) { TimelinePost.create(content: 'Test timeline post', user: user, tasks: [task]) }  
  describe 'バリデーションのテスト' do
    it 'コメントが必須であること' do
      timeline_post.content = nil
      expect(timeline_post).not_to be_valid
      expect(timeline_post.errors[:content]).to include('を入力してください')
    end
  
    it '少なくとも1つ以上のタスクが選択されていること' do
      timeline_post.tasks = []
      timeline_post.valid?
      expect(timeline_post.errors[:task_ids]).to include('少なくとも1つのタスクを選択してください。')
    end
  end
  
  describe 'アソシエーションのテスト' do
    it '投稿がユーザーに属すること' do
      expect(TimelinePost.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
    it '投稿が複数のタスクを持つこと' do
      expect(TimelinePost.reflect_on_association(:tasks).macro).to eq(:has_many)
    end
    it '投稿が複数の頑張ったね！を持つこと' do
      expect(TimelinePost.reflect_on_association(:reactions).macro).to eq(:has_many)
    end
  end
end
  

