require 'rails_helper'

RSpec.describe ProductStore, type: :model do
	describe 'validations' do
	  it 'validates presence of required fields' do
	    should validate_presence_of(:store_id)
	    should validate_presence_of(:product_id)
	  end

	  it 'validates relations' do
	    should belong_to(:product)
	    should belong_to(:store)
	  end
	end
end
