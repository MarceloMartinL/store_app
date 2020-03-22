require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  describe 'validations' do
    it 'validates presence of required fields' do
      should validate_presence_of(:product_id)
    end

    it 'validates relations' do
      should belong_to(:order)
      should belong_to(:product)
    end
  end
end
