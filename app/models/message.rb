class Message < ApplicationRecord
  validates :number, presence: true, numericality: { only_integer: true }
  validates :body, presence: true
  validates :lock_version, numericality: { only_integer: true }

  validates_associated :chat
  belongs_to :chat

  def self.get_all(application_id, chat_number)
    Application.find_by(token: application_id)&.chats&.find_by(number: chat_number)&.messages&.all&.as_json(:except => :id)
  end

  def self.create_message(application_id, chat_number, body)
    @messages = Application.find_by(token: application_id)&.chats&.find_by(number: chat_number)&.messages
    return if @messages.nil?

    @last_message_num = @messages&.last&.number
    @last_message_num = @last_message_num.nil? ? 0 : @last_message_num
    @last_message_num += 1

    @message = @messages.create!(body: body, number: @last_message_num)

    # @todo find a smarter way to update the messages_count
    @messages[0].chat.messages_count = @last_message_num
    @messages[0].chat.save

    @message.as_json(:except => :id)
  end

  def self.get_by_number(application_id, chat_number, message_number)
    Application.find_by(token: application_id)&.chats&.find_by(number: chat_number)&.messages&.find_by(number: message_number)&.as_json(:except => :id)
  end
end
