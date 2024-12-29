# frozen_string_literal: true

class TaskTimelinePost < ApplicationRecord
  belongs_to :task
  belongs_to :timeline_post
end
