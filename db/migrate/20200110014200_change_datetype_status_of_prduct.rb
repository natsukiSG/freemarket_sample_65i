class ChangeDatetypeStatusOfPrduct < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :status, :integer, null: false
    change_column :products, :costcharge, :integer, null: false
  end
end
