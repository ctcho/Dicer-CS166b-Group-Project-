class Blocking < ApplicationRecord
  belongs_to :user
  belongs_to :blocked, class_name: "User", foreign_key: "blocked_id"

  after_create :create_inverse, unless: :has_inverse?

  def has_inverse?
    User.find_by(id: self.user_id).blocked_by?(User.find_by(id: self.blocked_id))
  end

  def create_inverse
    a = Blocking.create(blocked_id: self.user_id, user_id: self.blocked_id)
  end
end
