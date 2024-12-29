# frozen_string_literal: true

class CreateJoinTableTasksTimelinePosts < ActiveRecord::Migration[6.0]
  def change
    create_join_table :tasks, :timeline_posts do |t|
      t.index :task_id
      t.index :timeline_post_id
    end
  end
end
