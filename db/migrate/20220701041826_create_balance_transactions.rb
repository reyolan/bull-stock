class CreateBalanceTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :balance_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount
      t.integer :transaction_type

      t.timestamps
    end
  end
end
