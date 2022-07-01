class CreateBalanceTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :balance_transactions do |t|

      t.timestamps
    end
  end
end
