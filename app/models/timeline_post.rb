class TimelinePost < ApplicationRecord
  has_and_belongs_to_many :tasks
  belongs_to :user
  has_many_attached :images
  has_many :reactions, dependent: :destroy
end
