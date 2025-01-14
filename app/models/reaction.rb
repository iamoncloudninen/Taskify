# frozen_string_literal: true

class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :timeline_post, counter_cache: true
end
