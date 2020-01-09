class CreateBrandCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :brand_categories do |t|
      t.string :name
      t.timestamps
    end
  end
end
