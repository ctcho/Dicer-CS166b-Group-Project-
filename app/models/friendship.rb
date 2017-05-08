class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"

  #after_create :create_inverse, unless: :has_inverse?

  def create_inverse
    x = User.find_by(id: self.user_id).friends.last
    Friendship.create(user_id: x.id, friend_id: User.find_by(id: self.user_id).id)
  end

  def has_inverse?
    User.find(self.user_id).friends.last.friends_with?(User.find_by(id: self.user_id))
  end
end
