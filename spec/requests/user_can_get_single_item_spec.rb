require 'rails_helper'

describe "get /api/v1/items/1" do
  before do
    1.times do |i|
      Item.create(name: "item ##{i}", description: "this is item ##{i}", image_url: "http://placehold.it/250x250")
    end
  end

  it "gets a 200 response and name,desc,image without timestamps" do
    item = Item.first
    get "/api/v1/items/#{item.id}"
    json_item = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq 200

    expect(json_item[:name]).to eq item.name
    expect(json_item[:description]).to eq item.description
    expect(json_item[:image_url]).to eq item.image_url
    expect(json_item[:created_at]).to be_nil
    expect(json_item[:updated_at]).to be_nil

  end

end
