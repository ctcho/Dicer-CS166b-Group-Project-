class ChatRoom < ApplicationRecord
  before_save :has_two_users
  has_many :messages
  #has_and_belongs_to_many :users
  has_many :chat_rooms_users
  has_many :users, through: :chat_rooms_users

  def has_two_users
    if ! (self.users.length >= 2)
      raise "Must have at least two users"
    end
  end
end
