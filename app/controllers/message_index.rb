class MessageIndex
  include SearchFlip::Index

  def self.index_name
    "messages"
  end

  def self.model
    Message
  end

  def self.serialize(message)
    {
      number: message.number,
      application: message.chat.application.token,
      chat: message.chat.number,
      body: message.body
    }
  end
end

MessageIndex.import(Message.all)