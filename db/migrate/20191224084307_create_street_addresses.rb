class CreateStreetAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :street_addresses do |t|
      t.string :address_first_name, null: false
      t.string :address_last_name, null: false
      t.string :address_first_name_kana, null: false
      t.string :address_last_name_kana, null: false
      t.integer :post_number, null: false
      t.string :prefectures, null: false
      t.string :city, null: false
      t.integer :house_number, null: false
      t.string :building_name
      t.integer :address_phone_number
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
