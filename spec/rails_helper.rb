# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'devise'
require 'capybara/rspec'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
# Add additional requires below this line. Rails is not loaded until this point!
# require 'support/your_helper_module'

RSpec.configure do |config|
  # == Rails-specific settings ==
  # If you use a different test framework or need to adjust this for your app,
  # please see https://relishapp.com/rspec/rspec-rails/docs
  config.fixture_path = Rails.root.join('spec/fixtures').to_s

  # Set to true to use transactional fixtures
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviour to your tests
  # based on their file location, for example you can write a controller test as:
  #
  #     it "does something" do
  #       expect(post :create, params: { user: { name: 'example' } }).to be_a(User)
  #     end
  #
  # The default is to include everything in spec/rails_helper.rb.
  # config.include Rails.application.routes.url_helpers
  config.infer_spec_type_from_file_location!
  config.include Rails.application.routes.url_helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :system
  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

