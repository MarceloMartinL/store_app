require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it 'validates relations' do
      should belong_to(:store)
      should have_many(:order_products).dependent(:destroy)
      should have_many(:products).through(:order_products)
    end
  end
end
