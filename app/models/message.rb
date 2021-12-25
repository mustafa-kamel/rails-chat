class Message < ApplicationRecord
  include SearchFlip::Model

  validates :number, presence: true, numericality: { only_integer: true }
  validates :body, presence: true
  validates :lock_version, numericality: { only_integer: true }

  validates_associated :chat
  belongs_to :chat

  def self.get_all(app_token, chat_number)
    Application.find_by(token: app_token)&.chats&.find_by(number: chat_number)&.messages&.all&.as_json(:except => [:id, :chat_id, :lock_version])
  end

  def self.create_message(app_token, chat_number, body)
    @chat = Application.find_by(token: app_token)&.chats&.find_by(number: chat_number)
    return if @chat.nil?
    @last_message_num = @chat.messages.nil? ? 0 : @chat.messages&.last&.number
    @last_message_num = @last_message_num.nil? ? 1 : @last_message_num + 1
    CreateMessageWorker.perform_async(app_token, chat_number, body, @last_message_num)
    {"number": @last_message_num, "body": body}
  end

  def self.get_by_number(app_token, chat_number, message_number)
    Application.find_by(token: app_token)&.chats&.find_by(number: chat_number)&.messages&.find_by(number: message_number)&.as_json(:except => [:id, :chat_id, :lock_version])
  end

  notifies_index(MessageIndex)
end
