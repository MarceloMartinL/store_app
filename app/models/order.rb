class Order < ApplicationRecord
  belongs_to :store

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :order_products, allow_destroy: true

  before_validation :set_order_price

  validate :products_belongs_to_store

  def set_order_price
    product_ids = order_products.reject(&:marked_for_destruction?).map { |order_product| order_product.product_id }
    total_price = Product.where(id: product_ids).sum(:price)
    self.price = total_price
  end

  def products_belongs_to_store
    order_products.reject(&:marked_for_destruction?).each do |order_product|
      product = order_product.product
      next unless product
      
      unless store.products.include?(product)
        errors.add(:base, "The product with ID=#{product.id} doesn't belongs to the store with ID=#{store.id}")
      end
    end
  end
end
