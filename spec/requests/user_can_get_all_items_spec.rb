require 'rails_helper'

describe "get /api/v1/items" do
  before do
    2.times do |i|
      Item.create(name: "item ##{i}", description: "this is item ##{i}", image_url: "http://placehold.it/250x250")
    end
  end

  it "gets a 200 response and name,desc,image without timestamps" do
    get '/api/v1/items'
    json_items = JSON.parse(response.body, symbolize_names: true)
    item_1 = Item.first
    item_2 = Item.last
    expect(response.status).to eq 200
    expect(Item.count).to eq 2
    expect(json_items.first[:name]).to eq item_1.name
    expect(json_items.first[:description]).to eq item_1.description
    expect(json_items.first[:image_url]).to eq item_1.image_url
    expect(json_items.first[:created_at]).to be_nil
    expect(json_items.first[:updated_at]).to be_nil


    expect(json_items.last[:name]).to eq item_2.name
    expect(json_items.last[:description]).to eq item_2.description
    expect(json_items.last[:image_url]).to eq item_2.image_url
    expect(json_items.last[:created_at]).to be_nil
    expect(json_items.last[:updated_at]).to be_nil

  end

end
