class User < ApplicationRecord
  has_one :dm_profile
  has_one :player_profile

end
