require 'rails_helper'

RSpec.describe CustomerItems, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :item }
  end
end