# frozen_string_literal: true

class AddDefaultToCompletedInTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :completed, from: nil, to: false
  end
end
