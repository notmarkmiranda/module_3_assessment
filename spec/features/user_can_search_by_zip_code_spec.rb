require 'rails_helper'

describe "user searches and gets to index" do

  it "returns 15 of 17 results for stores in an area" do
    VCR.use_cassette('store-search', :record => :new_episodes) do
      visit "/"
      fill_in "search[zip]", with: "80202"
      click_button "search"
      expect(current_path).to eq "/search"
      expect(page).to have_content("17 Total Stores")
      within(".results") do
        expect(page).to have_selector('.result', count: 15)
      end

      within(".results") do
        expect(page).to_not have_selector('#result-16')
        expect(page).to_not have_selector('#result-17')
      end

      within("#result-7") do
        expect(page).to have_content "Store Name: Best Buy - Northglenn"
        expect(page).to have_content "Store City: Denver"
        expect(page).to have_content "Store Distance from Zip: 9.12"
        expect(page).to have_content "Store Phone Number: 303-252-8677"
        expect(page).to have_content "Store Type: BigBox"
      end

      within("#result-14") do
        expect(page).to have_content "Store Name: Best Buy - S.E. Denver"
        expect(page).to have_content "Store City: Lone Tree"
        expect(page).to have_content "Store Distance from Zip: 14.98"
        expect(page).to have_content "Store Phone Number: 303-649-9474"
        expect(page).to have_content "Store Type: BigBox"
      end
    end
  end
end
