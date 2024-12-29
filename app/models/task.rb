# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  has_many :task_timeline_posts, dependent: :destroy
  has_many :timeline_posts, through: :task_timeline_posts
  validates :content, presence: true, length: { maximum: 255 }
  validates :deadline, presence: true
  validates :priority, inclusion: { in: [true, false] }
  validate :deadline_cannot_be_in_the_past, on: :create

  def deadline_cannot_be_in_the_past
    return unless deadline.present? && deadline < Time.zone.now

    errors.add(:deadline, 'は過去の日付を設定できません。')
  end
end
