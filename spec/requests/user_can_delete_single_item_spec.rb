require 'rails_helper'

describe "delete /api/v1/items" do
  before do
    2.times do |i|
      Item.create(name: "item ##{i}", description: "this is item ##{i}", image_url: "http://placehold.it/250x250")
    end
  end

  it "gets a 204 when deleting an item" do
    item = Item.last
    delete "/api/v1/items/#{item.id}"
    expect(response.status).to eq 204
  end
end
