require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'validations' do
    it 'validates presence of required fields' do
      should validate_presence_of(:name)
      should validate_presence_of(:address)
      should validate_presence_of(:phone)
    end

    it 'validates uniqueness of fields' do
    	should validate_uniqueness_of(:name)
    end

    it 'validates relations' do
      should have_many(:product_stores).dependent(:destroy)
      should have_many(:products).through(:product_stores)
      should have_many(:orders)
    end
  end
end