class Supermarket < ApplicationRecord
  has_many :customers
  has_many :customer_items, through: :customers
  has_many :items, through: :customer_items

  def unique_items
    items.select('items.name').group('items.name')
  end

  def top_3_items
    items.joins(:customers)
    .select('items.*, count(customers.id) as customer_count')
    .group("items.id")
    .order(customer_count: :desc)
    .limit(3)
  end
end