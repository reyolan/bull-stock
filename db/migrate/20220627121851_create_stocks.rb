class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :symbol
      t.string :company_name
      t.decimal :quantity
      t.decimal :unit_price
      t.decimal :amount

      t.timestamps
    end
  end
end
