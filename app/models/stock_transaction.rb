class StockTransaction < ApplicationRecord
  belongs_to :user
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  enum transaction_type: %i[buy sell]

  def buy_type
    self.transaction_type = 0
    self.amount = quantity * unit_price
    self
  end

  def sell_type
    self.transaction_type = 1
    self.amount = quantity * unit_price
    self
  end
end
