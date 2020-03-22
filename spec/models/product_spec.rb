require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'validates presence of required fields' do
      should validate_presence_of(:name)
      should validate_presence_of(:sku)
      should validate_presence_of(:type)
      should validate_presence_of(:price)
    end

    it 'validates inclusion of fields' do
    	should validate_inclusion_of(:type).in_array(['pizza', 'complement'])
    end

    it 'validates numericality of fields' do
      should validate_numericality_of(:price).is_greater_than_or_equal_to(0)
    end

    it 'validates relations' do
      should have_many(:product_stores).dependent(:destroy)
      should have_many(:stores).through(:product_stores)
    end
  end
end
