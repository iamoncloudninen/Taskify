# frozen_string_literal: true

class AddCompletedAtToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :completed_at, :datetime
  end
end
