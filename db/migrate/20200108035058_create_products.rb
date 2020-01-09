class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string      :name, null: false
      t.string      :comment, null: false
      t.integer	    :price, null: false
      t.string      :size
      t.string      :status, null: false
      t.string      :costcharge, null: false
      t.string      :delivery_way, null: false
      t.string      :delivery_area, null: false
      t.string      :delivery_date, null: false
      t.references  :buyer, foreign_key: { to_table: :users }
      t.references  :category, foreign_key: { to_table: :categories }
      t.references  :seller, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end

    add_index :products, :name, unique: true
  end
end
