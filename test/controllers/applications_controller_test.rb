require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @application = applications(:one)
  end

  test "should get index" do
    get applications_url, as: :json
    assert_response :success
  end

  test "should create application" do
    assert_difference('Application.count') do
      post applications_url, params: { application: { chats_count: @application.chats_count, lock_version: @application.lock_version, name: @application.name, token: @application.token } }, as: :json
    end

    assert_response 201
  end

  test "should show application" do
    get application_url(@application), as: :json
    assert_response :success
  end

  test "should update application" do
    patch application_url(@application), params: { application: { chats_count: @application.chats_count, lock_version: @application.lock_version, name: @application.name, token: @application.token } }, as: :json
    assert_response 200
  end

  test "should destroy application" do
    assert_difference('Application.count', -1) do
      delete application_url(@application), as: :json
    end

    assert_response 204
  end
end
