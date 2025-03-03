# frozen_string_literal: true

class RenameStatusToCompletedInTasks < ActiveRecord::Migration[6.1]
  def change
    rename_column :tasks, :status, :completed
  end
end
