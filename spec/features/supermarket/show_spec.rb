require 'rails_helper'

RSpec.describe 'the supermarket show page' do
  it "has the name of the supermarket" do
    supermarket_1 = Supermarket.create!(name: "Whole Foods", location: "Denver")
    supermarket_2 = Supermarket.create!(name: "Shaws", location: "Millbury")

    customer_1 = Customer.create!(name: "Hellfire", supermarket_id: supermarket_1.id)

    item_1 = Item.create!(name: "PB", price: 2)
    item_2 = Item.create!(name: "Jelly", price: 4)
    item_3 = Item.create!(name: "Bread", price: 6)

    customer_item_1 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
    customer_item_2 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
    customer_item_3 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_3.id)

    visit "/supermarkets/#{supermarket_1.id}"

    expect(page).to have_content("Whole Foods")
    expect(page).to_not have_content("Shaws")
  end

  it "has a link to the supermarkets item index page" do
    supermarket_1 = Supermarket.create!(name: "Whole Foods", location: "Denver")
    supermarket_2 = Supermarket.create!(name: "Shaws", location: "Millbury")

    customer_1 = Customer.create!(name: "Hellfire", supermarket_id: supermarket_1.id)

    item_1 = Item.create!(name: "PB", price: 2)
    item_2 = Item.create!(name: "Jelly", price: 4)
    item_3 = Item.create!(name: "Bread", price: 6)

    customer_item_1 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
    customer_item_2 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
    customer_item_3 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_3.id)

    visit "/supermarkets/#{supermarket_1.id}"

    expect(page).to have_link("View all this supermarkets items")
  end
end