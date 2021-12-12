class Application < ApplicationRecord
  has_secure_token :token

  validates :token, uniqueness:true 
  validates :name, presence:true 
  validates :chats_count, numericality: { only_integer: true }
  validates :lock_version, numericality: { only_integer: true }

  has_many :chats, dependent: :destroy
end
