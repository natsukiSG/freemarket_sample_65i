class CreateStreetaddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :streetaddresses do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :post_number, null: false
      t.integer :prefecture, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :building_name
      t.string :phone_number
      t.references :user, null: false, foreign_key:true

      t.timestamps
    end
  end
end