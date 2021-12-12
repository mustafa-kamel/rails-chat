require "test_helper"

class ChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chat = chats(:one)
  end

  test "should get index" do
    get chats_url, as: :json
    assert_response :success
  end

  test "should create chat" do
    assert_difference('Chat.count') do
      post chats_url, params: { chat: { application: @chat.application, id: @chat.id, lock_version: @chat.lock_version, messages_count: @chat.messages_count, number: @chat.number } }, as: :json
    end

    assert_response 201
  end

  test "should show chat" do
    get chat_url(@chat), as: :json
    assert_response :success
  end

  test "should update chat" do
    patch chat_url(@chat), params: { chat: { application: @chat.application, id: @chat.id, lock_version: @chat.lock_version, messages_count: @chat.messages_count, number: @chat.number } }, as: :json
    assert_response 200
  end

  test "should destroy chat" do
    assert_difference('Chat.count', -1) do
      delete chat_url(@chat), as: :json
    end

    assert_response 204
  end
end
