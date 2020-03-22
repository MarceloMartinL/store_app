class Store < ApplicationRecord
  has_many :product_stores, dependent: :destroy
  has_many :products, through: :product_stores
  has_many :orders

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :phone, presence: true
end
