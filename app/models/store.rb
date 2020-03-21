class Store < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :phone, presence: true
end
