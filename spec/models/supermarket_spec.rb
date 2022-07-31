require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :customers }
    it { should have_many(:customer_items).through(:customers) }
    it { should have_many(:items).through(:customer_items) }
  end

  describe 'instance methods' do
    it "has a UNIQUE list of all the items that the supermarket has" do
      supermarket_1 = Supermarket.create!(name: "Whole Foods", location: "Denver")
  
      customer_1 = Customer.create!(name: "Hellfire", supermarket_id: supermarket_1.id)
  
      item_1 = Item.create!(name: "PB", price: 2)
      item_2 = Item.create!(name: "Jelly", price: 4)
      item_3 = Item.create!(name: "Bread", price: 6)
      item_4 = Item.create!(name: "Bread", price: 6)
  
      customer_item_1 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
      customer_item_2 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
      customer_item_3 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_3.id)
      customer_item_3 = CustomerItem.create!(customer_id: customer_1.id, item_id: item_4.id)

      expect(supermarket_1.unique_items.length).to eq(3)
      #unsure how to check for variables inside an ActiveRecord::AssociationRelation
      #tried this originally => expect(supermarket_1.unique_items).to eq(["PB", "Jelly", "Bread"])
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

      expect(supermarket_1.top_3_items.first).to eq(item_1)
      expect(supermarket_1.top_3_items[1]).to eq(item_2)
      expect(supermarket_1.top_3_items.last).to eq(item_3)

      # expect(supermarket_1.top_3_items).to eq(["PB", "Jelly", "Bread"])
      #^^^^^keep running into getting an ActiveRecord::AssociationRelation instead of the elements I am wanting.
      #how do I solve this?
    end
  end
end