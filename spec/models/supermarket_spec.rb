require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :customers }
    it { should have_many(:customer_items).through(:customers) }
    it { should have_many(:items).through(:customer_items) }
  end
end