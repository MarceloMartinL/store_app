class CreateProductStores < ActiveRecord::Migration[5.2]
  def change
    create_table :product_stores do |t|
      t.references :product, foreign_key: true, index: true
      t.references :store, foreign_key: true, index: true
      t.index [:product_id, :store_id], unique: true

      t.timestamps
    end
  end
end
