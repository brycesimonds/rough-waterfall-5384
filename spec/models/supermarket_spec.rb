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

      expect(supermarket_1.unique_items).to have_content(["PB", "Jelly", "Bread"])
    end
  end
end