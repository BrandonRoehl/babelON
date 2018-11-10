require "application_system_test_case"

class LocalizationsTest < ApplicationSystemTestCase
  setup do
    @localization = localizations(:one)
  end

  test "visiting the index" do
    visit localizations_url
    assert_selector "h1", text: "Localizations"
  end

  test "creating a Localization" do
    visit localizations_url
    click_on "New Localization"

    fill_in "Content", with: @localization.content
    fill_in "Lang", with: @localization.lang
    fill_in "Message", with: @localization.message_id
    click_on "Create Localization"

    assert_text "Localization was successfully created"
    click_on "Back"
  end

  test "updating a Localization" do
    visit localizations_url
    click_on "Edit", match: :first

    fill_in "Content", with: @localization.content
    fill_in "Lang", with: @localization.lang
    fill_in "Message", with: @localization.message_id
    click_on "Update Localization"

    assert_text "Localization was successfully updated"
    click_on "Back"
  end

  test "destroying a Localization" do
    visit localizations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Localization was successfully destroyed"
  end
end
