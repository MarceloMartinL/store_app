class Product < ApplicationRecord
	self.inheritance_column = :_type_disabled

	PRODUCT_TYPES = ['pizza', 'complement']

	has_many :product_stores, dependent: :destroy
	has_many :stores, through: :product_stores

	validates :name, presence: true
	validates :sku, presence: true
	validates :type, presence: true, inclusion: { in: PRODUCT_TYPES }
	validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
