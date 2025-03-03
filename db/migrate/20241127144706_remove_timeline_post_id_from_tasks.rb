# frozen_string_literal: true

class RemoveTimelinePostIdFromTasks < ActiveRecord::Migration[6.1]
  def change
    return unless column_exists?(:tasks, :timeline_post_id)

    remove_column :tasks, :timeline_post_id, :integer
  end
end
