# frozen_string_literal: true

class TimelinePost < ApplicationRecord
  has_many :task_timeline_posts, dependent: :destroy
  has_many :tasks, through: :task_timeline_posts
  belongs_to :user
  has_many_attached :images
  has_many :reactions, dependent: :destroy
  validates :content, presence: true
  validate :at_least_one_task_selected

  private

  def at_least_one_task_selected
    return unless task_ids.blank? || task_ids.reject(&:blank?).empty?

    errors.add(:task_ids, '少なくとも1つのタスクを選択してください。')
  end
end
