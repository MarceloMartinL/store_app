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
  end
end
