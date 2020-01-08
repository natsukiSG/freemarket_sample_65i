class AddBrandToProduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :size, index: true, foreign_key: true, null: true
    add_reference :products, :brand, index: true, foreign_key: true, null: true
  end
end
