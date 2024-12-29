# frozen_string_literal: true

class CreateTaskTimelinePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :task_timeline_posts do |t|
      t.references :task, null: false, foreign_key: true
      t.references :timeline_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
