require 'rails_helper'

describe "post /api/v1/items" do

  it "gets a 201 when creating an item" do
    item_stuff = { name: "mark", description: "mark's item description", image_url: "http://placehold.it/250x250" }
    post "/api/v1/items", item_stuff
    expect(response.status).to eq 201
    json_item = JSON.parse(response.body, symbolize_names: true)

    expect(json_item[:name]).to eq item_stuff[:name]
    expect(json_item[:description]).to eq item_stuff[:description]
    expect(json_item[:image_url]).to eq item_stuff[:image_url]
    expect(json_item[:created_at]).to be_nil
    expect(json_item[:updated_at]).to be_nil

  end
end
