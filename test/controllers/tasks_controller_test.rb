# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get tasks_index_url
    assert_response :success
  end

  test 'should get show' do
    get tasks_show_url
    assert_response :success
  end

  test 'should get new' do
    get tasks_new_url
    assert_response :success
  end

  test 'should get edit' do
    get tasks_edit_url
    assert_response :success
  end

  test 'should get post' do
    get tasks_post_url
    assert_response :success
  end
end
