require 'rails_helper'

RSpec.describe 'the customer show' do
  it "has a list of the customers items" do
    supermarket_1 = Supermarket.create!(name: "Whole Foods", location: "Denver")

    customer_1 = Customer.create!(name: "Hellfire", supermarket_id: supermarket_1.id)

    item_1 = Item.create!(name: "PB", price: 2)
    item_2 = Item.create!(name: "Jelly", price: 4)
    item_3 = Item.create!(name: "Bread", price: 6)
    item_4 = Item.create!(name: "Hot Sauce", price: 8)

    customer_item_1 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
    customer_item_2 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
    customer_item_3 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_3.id)

    visit "/customers/#{customer_1.id}"

    expect(page).to have_content("PB")
    expect(page).to have_content("Jelly")
    expect(page).to have_content("Bread")
    expect(page).to_not have_content("Hot Sauce")
  end

  it "has the name of the supermarket the customer belongs to" do
    supermarket_1 = Supermarket.create!(name: "Whole Foods", location: "Denver")
    supermarket_2 = Supermarket.create!(name: "Shaws", location: "Millbury")

    customer_1 = Customer.create!(name: "Hellfire", supermarket_id: supermarket_1.id)

    item_1 = Item.create!(name: "PB", price: 2)
    item_2 = Item.create!(name: "Jelly", price: 4)
    item_3 = Item.create!(name: "Bread", price: 6)

    customer_item_1 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
    customer_item_2 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
    customer_item_3 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_3.id)

    visit "/customers/#{customer_1.id}"
   
    expect(page).to have_content("The supermarket this customer belongs to is: Whole Foods")
    expect(page).to_not have_content("The supermarket this customer belongs to is: Shaws")
  end

  it "shows the total price of all its items" do
    supermarket_1 = Supermarket.create!(name: "Whole Foods", location: "Denver")

    customer_1 = Customer.create!(name: "Hellfire", supermarket_id: supermarket_1.id)

    item_1 = Item.create!(name: "PB", price: 2)
    item_2 = Item.create!(name: "Jelly", price: 4)
    item_3 = Item.create!(name: "Bread", price: 6)

    customer_item_1 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
    customer_item_2 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
    customer_item_3 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_3.id)

    visit "/customers/#{customer_1.id}"
   
    expect(page).to have_content("Total price of all items: $12.00")
  end
end