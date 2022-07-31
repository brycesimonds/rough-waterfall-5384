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

  it "the link takes you to all the supermarkets items" do
    supermarket_1 = Supermarket.create!(name: "Whole Foods", location: "Denver")

    customer_1 = Customer.create!(name: "Hellfire", supermarket_id: supermarket_1.id)

    item_1 = Item.create!(name: "PB", price: 2)
    item_2 = Item.create!(name: "Jelly", price: 4)
    item_3 = Item.create!(name: "Bread", price: 6)

    customer_item_1 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
    customer_item_2 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
    customer_item_3 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_3.id)

    visit "/supermarkets/#{supermarket_1.id}"

    click_on 'View all this supermarkets items'

    expect(current_path).to eq("/supermarkets/#{supermarket_1.id}/items")
  end

  it "shows the three most popular items that are available in the supermarket" do
    supermarket_1 = Supermarket.create!(name: "Whole Foods", location: "Denver")

    customer_1 = Customer.create!(name: "Hellfire", supermarket_id: supermarket_1.id)
    customer_2 = Customer.create!(name: "Coldocean", supermarket_id: supermarket_1.id)
    customer_3 = Customer.create!(name: "Johnny", supermarket_id: supermarket_1.id)
    customer_4 = Customer.create!(name: "Suzy", supermarket_id: supermarket_1.id)
    customer_5 = Customer.create!(name: "Fiver", supermarket_id: supermarket_1.id)

    item_1 = Item.create!(name: "PB", price: 2)
    item_2 = Item.create!(name: "Jelly", price: 4)
    item_3 = Item.create!(name: "Bread", price: 6)
    item_4 = Item.create!(name: "Hot Sauce", price: 8)

    customer_item_1 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
    customer_item_2 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
    customer_item_3 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_3.id)

    customer_item_4 = CustomerItem.create!(customer_id: customer_2.id, item_id: item_1.id)
    customer_item_5 = CustomerItem.create!(customer_id: customer_2.id, item_id: item_2.id)

    customer_item_6 = CustomerItem.create!(customer_id: customer_3.id, item_id: item_4.id)

    customer_item_7 = CustomerItem.create!(customer_id: customer_4.id, item_id: item_1.id)
    customer_item_7 = CustomerItem.create!(customer_id: customer_4.id, item_id: item_3.id)

    customer_item_8 = CustomerItem.create!(customer_id: customer_5.id, item_id: item_1.id)
    customer_item_8 = CustomerItem.create!(customer_id: customer_5.id, item_id: item_2.id)

    visit "/supermarkets/#{supermarket_1.id}"

    within '#3-popular-items' do
      expect(page).to have_content("PB")
      expect(page).to have_content("Jelly")
      expect(page).to have_content("Bread")
      expect(page).to_not have_content("Hot Sauce")
    end
  end
end