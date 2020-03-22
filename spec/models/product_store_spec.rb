require 'rails_helper'

RSpec.describe ProductStore, type: :model do
  it 'validates presence of required fields' do
    should validate_presence_of(:store_id)
    should validate_presence_of(:product_id)
  end
end
