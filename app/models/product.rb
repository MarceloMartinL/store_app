class Product < ApplicationRecord
	self.inheritance_column = :_type_disabled

	has_many :product_stores, dependent: :destroy
	has_many :stores, through: :product_stores

	validates :name, presence: true
	validates :sku, presence: true
	validates :type, presence: true
	validates :price, presence: true
end
