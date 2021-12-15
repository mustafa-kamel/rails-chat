class Message < ApplicationRecord
  validates :number, presence: true, numericality: { only_integer: true }
  validates :body, presence: true
  validates :lock_version, numericality: { only_integer: true }

  validates_associated :chat
  belongs_to :chat

  def self.get_all(application_id, chat_number)
    Application.find_by(token: application_id)&.chats&.find_by(number: chat_number)&.messages&.all&.as_json(:except => [:id, :chat_id, :lock_version])
  end

  def self.create_message(application_id, chat_number, body)
    @chat = Application.find_by(token: application_id)&.chats&.find_by(number: chat_number)
    return if @chat.nil?
    @last_message_num = @chat.messages.nil? ? 0 : @chat.messages&.last&.number
    @last_message_num = @last_message_num.nil? ? 1 : @last_message_num + 1
    @message = @chat.messages.create!(body: body, number: @last_message_num)
    @message.as_json(:except => [:id, :chat_id, :lock_version])
  end

  def self.get_by_number(application_id, chat_number, message_number)
    Application.find_by(token: application_id)&.chats&.find_by(number: chat_number)&.messages&.find_by(number: message_number)&.as_json(:except => [:id, :chat_id, :lock_version])
  end
end
