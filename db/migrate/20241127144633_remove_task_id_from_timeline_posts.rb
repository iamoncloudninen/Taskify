# frozen_string_literal: true

class RemoveTaskIdFromTimelinePosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :timeline_posts, :task_id, :integer
  end
end
