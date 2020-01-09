class CreateSetBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :set_brands do |t|
      t.references :brand, null: false, foreign_key:true
      t.references :brand_category, null: false, foreign_key:true
      t.timestamps
    end
  end
end
