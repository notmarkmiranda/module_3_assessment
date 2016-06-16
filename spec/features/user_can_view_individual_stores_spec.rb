require 'rails_helper'


describe "user searches and gets to show page" do
  it "returns an index, can click on individual store show page" do
    VCR.use_cassette('store-show', :record => :new_episodes) do
      # The name will be a link in the next story:
      # As a user
      # After I have searched a zip code for stores
      visit "/"
      fill_in "search[zip]", with: "80202"
      click_button "search"
      expect(current_path).to eq "/search"
      # When I click the name of a store
      click_link "Best Buy - Northglenn"
      # Then my current path should be "/stores/:store_id"
      expect(current_path).to eq "/stores/1416"
      within(".container") do
        expect(page).to have_content "Store Name: Best Buy - Northglenn"
        expect(page).to have_content "Store Type: BigBox"
        expect(page).to have_content "Address: 104 W 104th Ave"
        expect(page).to have_content "City, State, Zip: Denver, CO 80234"
      end
      within(".hours") do
        expect(page).to have_content "Mon: 10am-9pm"
        expect(page).to have_content "Tue: 10am-9pm"
        expect(page).to have_content "Wed: 10am-9pm"
        expect(page).to have_content "Thurs: 10am-9pm"
        expect(page).to have_content "Fri: 10am-10pm"
        expect(page).to have_content "Sat: 10am-10pm"
        expect(page).to have_content "Sun: 10am-8pm"
      end
    end
  end
end
