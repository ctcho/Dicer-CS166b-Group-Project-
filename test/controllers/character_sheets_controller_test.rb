require 'test_helper'




class CharacterSheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @player_profile = player_profiles(:one)
    @character_sheet = character_sheets(:one)
    @player_profile.update(user: @user)
    @user.update(player_profile: @player_profile)
    @character_sheet.update(player_profile: @player_profile, file_path: "Updated/Path")
  end

  test "should get index" do
    character_sheets(:two).update(player_profile_id: player_profiles(:two).id)
    get user_player_profiles_character_sheets_url(@user, @player_profile)
    assert_response :success
  end

  test "should get new" do
    get new_user_player_profiles_character_sheet_url(@user)
    assert_response :success
  end

  test "should create character_sheet" do
    assert_difference('CharacterSheet.count') do
      post user_player_profiles_character_sheets_url(@player_profile), params: { character_sheet: { file_path: @character_sheet.file_path, player_profile_id: @character_sheet.player_profile_id } }
    end

    assert_redirected_to user_player_profiles_character_sheet_url(@user, CharacterSheet.last)
  end

  test "should show character_sheet" do
    get user_player_profiles_character_sheet_url(@user, @character_sheet)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_player_profiles_character_sheet_url(@user, @character_sheet)
    assert_response :success
  end

  test "should update character_sheet" do
    patch user_player_profiles_character_sheet_url(@user, @character_sheet), params: { character_sheet: { file_path: @character_sheet.file_path, player_profile_id: @character_sheet.player_profile_id } }
    assert_redirected_to user_player_profiles_character_sheet_url(@user, @character_sheet)
  end

  test "should destroy character_sheet" do
    assert_difference('CharacterSheet.count', -1) do
      delete user_player_profiles_character_sheet_url(@user, @character_sheet)
    end

    assert_redirected_to user_player_profiles_character_sheets_url
  end
end
