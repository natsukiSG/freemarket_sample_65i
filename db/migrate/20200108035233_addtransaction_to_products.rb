class AddtransactionToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :transaction_id, :integer
  end
end
