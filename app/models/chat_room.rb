class ChatRoom < ApplicationRecord
  has_many :messages
  #has_and_belongs_to_many :users
  has_many :chat_rooms_users
  has_many :users, through: :chat_rooms_users
end
