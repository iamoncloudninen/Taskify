class Task < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :timeline_posts
  validates :content, presence: true, length: { maximum: 255 }
  validates :deadline, presence: true
  validates :priority, inclusion: { in: [true, false] }
  validate :deadline_cannot_be_in_the_past

  def deadline_cannot_be_in_the_past
    if deadline.present? && deadline < Time.zone.now
      errors.add(:deadline, "は過去の日付を設定できません。")
    end
  end
end
