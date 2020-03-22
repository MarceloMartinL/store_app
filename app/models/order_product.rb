class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :product_id, presence: true
end
