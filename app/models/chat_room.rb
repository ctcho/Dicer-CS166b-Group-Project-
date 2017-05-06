class ChatRoom < ApplicationRecord
  has_one :owner, :class_name => "User"
  #before_save :has_two_users
  has_many :messages
  #has_and_belongs_to_many :users
  has_many :chat_rooms_users
  has_many :users, through: :chat_rooms_users
  has_attached_file :avatar, styles: { medium: "175x175>", thumb: "100x100>", smallerthumb: "35x35>"}, default_url: ":style/dicepic.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  # if someone leaves a 2 person chat it should destroy the chat. Fix this
  #def has_two_users
  #  if ! (self.users.length >= 2)
  #    raise "Must have at least two users"
  #  end
  #end
end
