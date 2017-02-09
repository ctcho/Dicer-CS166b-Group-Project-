require 'test_helper'

class CharacterSheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @character_sheet = character_sheets(:one)
  end

  test "should get index" do
    get character_sheets_url
    assert_response :success
  end

  test "should get new" do
    get new_character_sheet_url
    assert_response :success
  end

  test "should create character_sheet" do
    assert_difference('CharacterSheet.count') do
      post character_sheets_url, params: { character_sheet: { bio: @character_sheet.bio, filename: @character_sheet.filename, user_id: @character_sheet.user_id } }
    end

    assert_redirected_to character_sheet_url(CharacterSheet.last)
  end

  test "should show character_sheet" do
    get character_sheet_url(@character_sheet)
    assert_response :success
  end

  test "should get edit" do
    get edit_character_sheet_url(@character_sheet)
    assert_response :success
  end

  test "should update character_sheet" do
    patch character_sheet_url(@character_sheet), params: { character_sheet: { bio: @character_sheet.bio, filename: @character_sheet.filename, user_id: @character_sheet.user_id } }
    assert_redirected_to character_sheet_url(@character_sheet)
  end

  test "should destroy character_sheet" do
    assert_difference('CharacterSheet.count', -1) do
      delete character_sheet_url(@character_sheet)
    end

    assert_redirected_to character_sheets_url
  end
end
