require 'rails_helper'

RSpec.describe EmployeeTicket, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
  end
end