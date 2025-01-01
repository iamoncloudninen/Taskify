# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'bundler/setup'

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.run_all_when_everything_filtered = true
  config.order = :random
  Kernel.srand config.seed
end
