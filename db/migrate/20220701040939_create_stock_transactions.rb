class CreateStockTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :stock_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.string  :symbol
      t.string  :company_name
      t.decimal :unit_price
      t.decimal :quantity
      t.decimal :amount
      t.integer :transaction_type

      t.timestamps
    end
  end
end
