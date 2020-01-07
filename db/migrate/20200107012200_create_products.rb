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
      t.bigint  :buyer, foreign_key: { to_table: :users }, null: false
      t.bigint  :seller, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end