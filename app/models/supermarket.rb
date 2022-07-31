class Supermarket < ApplicationRecord
  has_many :customers
  has_many :customer_items, through: :customers
  has_many :items, through: :customer_items

  def unique_items
    items.select('items.name').group('items.name')
  end
end