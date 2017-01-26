require_relative '../rails_helper'

describe "the basic search", js: true do

  before do
    visit '/'
  end
  
  it "shows an empty search message if no searches have been ran" do
    expect(page).to have_content 'Nobody has searched for any regions yet'
  end

  it "allows you to fill in a city and returns a search result" do
    fill_in "search_result[search_term]", with: "Baltimore"
    click_button 'Find Timezone'
    expect(page).to have_content "Baltimore, MD - United States"
  end
end