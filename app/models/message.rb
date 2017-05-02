class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  scope :for_display, -> { order(:created_at).last(50) }
end
