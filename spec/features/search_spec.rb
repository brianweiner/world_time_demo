require_relative '../rails_helper'

describe "the basic search", js: true do

  describe "as a guest" do
    before do
      visit '/'
    end
  
    it "shows an empty search message if no searches have been ran" do
      expect(page).to have_content 'Nobody has searched for any regions yet'
    end

    it "allows you to fill in a city and returns a search result" do
      fill_in "search_result[search_term]", with: "Baltimore"
      click_button 'Find Timezone'

      expect(page).to have_content "Baltimore Maryland United States", wait: 9
    end

    it "returns an error message with a bad search" do
      fill_in "search_result[search_term]", with: "Mxyzpltk"
      click_button 'Find Timezone'
      expect(page).to have_content "We couldn't find a matching location", wait: 30
    end
  end

  describe "as a signed in user" do
    before do
      create(:user, email: 'brian@example.com', password: 'kokothemonkey')
      visit "/"
      click_on "Sign in"
      fill_in 'Email', with: 'brian@example.com'
      fill_in 'Password', with: 'kokothemonkey'
      click_on "Log in"
    end

    it "allows you to fill in a city and returns a search result" do
      fill_in "search_result[search_term]", with: "Baltimore"
      click_button 'Find Timezone'
      expect(page).to have_content "Baltimore Maryland United States", wait: 9
      click_on 'My Searches'
      expect(page).to have_content "Baltimore Maryland United States"
    end
  end
end