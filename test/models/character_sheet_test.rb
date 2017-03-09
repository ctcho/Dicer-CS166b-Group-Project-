require 'test_helper'

class CharacterSheetTest < ActiveSupport::TestCase

  test "filepath validation works" do
    c = CharacterSheet.create(player_profile: player_profiles(:one))
    s = CharacterSheet.create(player_profile: player_profiles(:two), file_path: "I am a silly person")
    assert (!c.valid? && s.valid?)
  end
end
